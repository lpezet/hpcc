IMPORT $;

EXPORT GeometryLite := MODULE

      EXPORT ExtLibSpatial := MODULE
        /* SpatialReferenceForSRID

              Given a SRID return the WKT representing the Spatial Projection Details for that SRID
        */
        export STRING SpatialReferenceForSRID(INTEGER4 srid) :=
                BEGINC++
#option library 'geos'
#option library 'proj'
#option library 'gdal'

// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once

#include <iostream>
#include <sstream>
#include <string>
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "gdal_priv.h"

using namespace std;

#body
// #body : tell HPCC that everything up to this point is in global scope and that
// the following section is to be encapsulated into a function/procedure

char *wktOut;

// determine the spatial reference details
OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
poSRS->importFromEPSG(srid);

poSRS->exportToWkt(&wktOut);

// copy string into a char array
unsigned len = strlen(wktOut);
char * out = (char *) malloc(len);
for(unsigned i=0; i < len; i++) {
    out[i] = wktOut[i];
}

// free resources
free(wktOut);
OGRSpatialReference::DestroySpatialReference(poSRS);


//return result to ECL
__result = out;

// set length of return string
__lenResult = len;
ENDC++;
/* tranformToProjection

             Transform a geometry from one SRID projection to another
*/
EXPORT string tranformToProjection(const string  geom,  STRING srs1, STRING srs2):=
        BEGINC++
#option library 'geos'
#option library 'proj'
#option library 'gdal'

// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once

#include <iostream>
#include <sstream>
#include <string>
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "gdal_priv.h"

        using namespace std;

#body
// #body : tell HPCC that everything up to this point is in global scope and that
// the following section is to be encapsulated into a function/procedure

OGRGeometry *thisGeom;
char *wkt;
char* wktIn = (char*) geom;


// determine the spatial reference details
char* wktSRSSourceIn = (char*) srs1;
OGRSpatialReference *sourceSRS = new OGRSpatialReference(NULL);
sourceSRS->importFromWkt(&wktSRSSourceIn);

char* wktSRSTargetIn = (char*) srs2;
OGRSpatialReference *targetSRS = new OGRSpatialReference(NULL);
targetSRS->importFromWkt(&wktSRSTargetIn);


// create geometry from given WKT
OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, sourceSRS, &thisGeom);

thisGeom->transformTo(targetSRS);

thisGeom->exportToWkt(&wkt);

unsigned len = strlen(wkt);

// copy string into a char array
char * out = (char *) malloc(len);
for(unsigned i=0; i < len; i++) {
    out[i] = wkt[i];
}

//return result to ECL
__result = out;

// set length of return string
__lenResult = len;

free(wkt);
OGRSpatialReference::DestroySpatialReference(sourceSRS);
OGRSpatialReference::DestroySpatialReference(targetSRS);
OGRGeometryFactory::destroyGeometry(thisGeom);
ENDC++;


/* distanceBetween

        Get the distance between the 2 given WKT geometries, the distance unit returned depdends on the SRID used
*/
EXPORT REAL8 distanceBetween(const string  geom1, const string  geom2, STRING srs):=
        BEGINC++
#option library 'geos'
#option library 'proj'
#option library 'gdal'

// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once

#include <iostream>
#include <sstream>
#include <string>
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "gdal_priv.h"

        using namespace std;

#body

// #body : tell HPCC that everything up to this point is in global scope and that
// the following section is to be encapsulated into a function/procedure


// determine the spatial reference details
char* wktSRSIn = (char*) srs;
OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
poSRS->importFromWkt(&wktSRSIn);

bool hasAtLeastOneValidRelation = false;

char* wktInLeft = (char*) geom1;
char* wktInRight = (char*) geom2;

OGRGeometry *leftOGRGeom;
OGRGeometry *rightOGRGeom;

bool loadedOK = false;
OGRErr err =  NULL;

err = OGRGeometryFactory::createFromWkt(&wktInLeft, poSRS, &leftOGRGeom);
loadedOK = (err == OGRERR_NONE);

err = OGRGeometryFactory::createFromWkt(&wktInRight, poSRS, &rightOGRGeom);
loadedOK = (err == OGRERR_NONE);

double distance = leftOGRGeom->Distance(rightOGRGeom);

OGRGeometryFactory::destroyGeometry(leftOGRGeom);
OGRGeometryFactory::destroyGeometry(rightOGRGeom);
OGRSpatialReference::DestroySpatialReference(poSRS);

return distance;
ENDC++;

/* hasSpatialRelation

     Do the two given WKT geometries have at least one of the expected relations defined in relationTypeORBits [a single INT containing OR'd bits]

     @see <a href="http://en.wikipedia.org/wiki/DE-9IM">Wikipedia</a>

     usage:
     hasSpatialRelation("POINT(? ?)","POLYGON((? ?,? ?,? ?,? ?,? ?))", rel.WITHIN | rel.OVERLAPS, SRS(4326));


     @param geom1 STRING containing a WKT geometry, left side of predicate assertion
     @param geom2 STRING containing a WKT geometry, right side of predicate assertion
     @param rel INTEGER contains one or more bits representing what spatial relations should be evaluated
     @param srs the WKT Spatial reference details as got from Operation.SRS
*/
EXPORT boolean hasSpatialRelation(const string  geom1, const string  geom2, INTEGER rel, STRING srs):=
        BEGINC++
#option library 'geos'
#option library 'proj'
#option library 'gdal'

// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once

#include <iostream>
#include <sstream>
#include <string>
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "gdal_priv.h"

    /**
    Enumeration of all supported relation types
    */
        namespace RelationType {
    enum SpatialPredicate {
        INTERSECTS = 1 << 0,
        TOUCHES = 1 << 1,
        DISJOINT = 1 << 2,
        CROSSES = 1 << 3,
        WITHIN = 1 << 4,
        CONTAINS = 1 << 5,
        OVERLAPS = 1 << 6,
        EQUALS = 1 << 7
    };

    bool isBitwiseSpatialPredicate(int packedInteger, RelationType::SpatialPredicate predicate) {
        return (packedInteger & predicate) == predicate ;
    }
}

using namespace std;

#body

  // #body : tell HPCC that everything up to this point is in global scope and that
// the following section is to be encapsulated into a function/procedure


// determine the spatial reference details
char* wktSRSIn = (char*) srs;
OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
poSRS->importFromWkt(&wktSRSIn);

bool hasAtLeastOneValidRelation = false;

char* wktInLeft = (char*) geom1;
char* wktInRight = (char*) geom2;

OGRGeometry *leftOGRGeom;
OGRGeometry *rightOGRGeom;

bool loadedOK = false;
OGRErr err =  NULL;

// parse geom 1
err = OGRGeometryFactory::createFromWkt(&wktInLeft, poSRS, &leftOGRGeom);
loadedOK = (err == OGRERR_NONE);

if(loadedOK) {
    // parse geom 2
    err = OGRGeometryFactory::createFromWkt(&wktInRight, poSRS, &rightOGRGeom);
    loadedOK = (err == OGRERR_NONE);

    if(loadedOK) {
        // assert if a relation exists
        int relationTypePackedBitwise = rel;
        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::INTERSECTS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Intersects(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::TOUCHES)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Touches(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::DISJOINT)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Disjoint(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::CROSSES)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Crosses(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::WITHIN)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Within(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::CONTAINS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Contains(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::OVERLAPS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Overlaps(rightOGRGeom);
        } 

        if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::EQUALS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Equals(rightOGRGeom);
        }
        // clean right
        OGRGeometryFactory::destroyGeometry(rightOGRGeom);
    }
    // clean left
    OGRGeometryFactory::destroyGeometry(leftOGRGeom);
}
// return result
return hasAtLeastOneValidRelation;
ENDC++;

EXPORT SRS :=  SpatialReferenceForSRID;
END;

EXPORT Filter :=  MODULE
      /*
      Bitwise enumeration for all possible Spatial Relations

      Can be combined e.g.

      All WITHIN or TOUCHING OR INTERSECTING = RelationType.WITHIN | RelationType.TOUCHES | RelationType.INTERSECTS
      */
      EXPORT RelationType := ENUM
        (
            INTERSECTS = 1 << 0,
            TOUCHES = 1 << 1,
            DISJOINT = 1 << 2,
            CROSSES = 1 << 3,
            WITHIN = 1 << 4,
            CONTAINS = 1 << 5,
            OVERLAPS = 1 << 6,
            EQUALS = 1 << 7
        );


/*
     hasSpatialRelation

     Does [this] and [thatOther] have one of the bitwise RelationTypes given in [relationTypeORBits] ?
*/
EXPORT BOOLEAN hasSpatialRelation(const string  this, const string  thatOther, INTEGER relationTypeORBits,
                                  INTEGER4 srid) := FUNCTION
                                              STRING srs := ExtLibSpatial.SRS(srid);
return ExtLibSpatial.hasSpatialRelation(this,thatOther,relationTypeORBits, srs);
END;

/*
    isWithin
*/
EXPORT BOOLEAN isWithin(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
            return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.WITHIN, srid);
END;
END;

EXPORT Operation :=  MODULE
      EXPORT STRING tranformToProjection(const string geometryWKT, INTEGER4 sourceSRID, INTEGER4 targetSRID) := FUNCTION
                  STRING srs1 :=  ExtLibSpatial.SRS(sourceSRID);
                  STRING srs2 :=  ExtLibSpatial.SRS(targetSRID);

           return ExtLibSpatial.tranformToProjection(geometryWKT,srs1,srs2);
END;

/*
    distanceBetween

    Calculate the distance between 2 points, using the projection given by srid
*/
EXPORT REAL8 distanceBetween(const string  point_A_WKT, const string  point_B_WKT, INTEGER4 srid) := FUNCTION
            STRING srs := ExtLibSpatial.SRS(srid);
return ExtLibSpatial.distanceBetween(point_A_WKT,point_B_WKT,srs);
END;
END;

EXPORT toSRID :=  Operation.tranformToProjection;
EXPORT distanceBetween :=  Operation.distanceBetween;
EXPORT isWithin :=  Filter.isWithin;
END;
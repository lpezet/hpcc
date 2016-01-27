EXPORT School := MODULE

	EXPORT raw_layout(UNSIGNED pYear) := RECORD
		STRING	survyear	; //	pos=1	, type=AN	, desc=Year corresponding to survey
		STRING	ncessch	; //	pos=2	, type=AN	, desc=Unique NCES public school ID (7-digit NCES agency ID (LEAID) + 5-digit NCES school ID
		STRING	fipst	; //	pos=3	, type=AN	, desc=American National Standards Institute (ANSI) state
		STRING	leaid	; //	pos=4	, type=AN	, desc=NCES local education agency (LEA)
		STRING	schno	; //	pos=5	, type=AN	, desc=NCES school
		STRING	stid	; //	pos=6	, type=AN	, desc=States own ID for the education
		STRING	seasch	; //	pos=7	, type=AN	, desc=States own ID for the
		STRING	leanm	; //	pos=8	, type=AN	, desc=Name of the education agency that operates this
		STRING	schnam	; //	pos=9	, type=AN	, desc=Name of the
		STRING	phone	; //	pos=10	, type=AN	, desc=Telephone number of
		STRING	mstree	; //	pos=11	, type=AN	, desc=The mailing address of the school may be a street address, a P.O. Box number, or, if verified that there is
		STRING	mcity	; //	pos=12	, type=AN	, desc=School mailing address
		STRING	mstate	; //	pos=13	, type=AN	, desc=Two-letter U.S. Postal Service abbreviation of the state where the mailing address is located (see ANSI
		STRING	mzip	; //	pos=14	, type=AN	, desc=Five-digit U.S. Postal Service ZIP code for the mailing
		STRING	mzip4	; //	pos=15	, type=AN	, desc=Four-digit (ZIP+4) code for the mailing address. If the mailing address has been assigned the
		STRING	lstree	; //	pos=16	, type=AN	, desc=School location street
		STRING	lcity	; //	pos=17	, type=AN	, desc=School location
		STRING	lstate	; //	pos=18	, type=AN	, desc=Two-letter U.S. Postal Service abbreviation of the state where the school address is located (see
		STRING	lzip	; //	pos=19	, type=AN	, desc=Five-digit U.S. Postal Service ZIP code for the location
		STRING	lzip4	; //	pos=20	, type=AN	, desc=Four-digit (ZIP+4) code for the location address. If the location address has been assigned the
		STRING	type	; //	pos=21	, type=AN	, desc=NCES code for type of
		STRING	status	; //	pos=22	, type=AN	, desc=NCES code for the school
		IFBLOCK(pYear > 2010)
			STRING	union	; //	pos=23	, type=AN	, desc=Supervisory Union Identification Number. For supervisory union administrative centers and
		END;
		STRING	ulocal	; //	pos=24	, type=AN	, desc=NCES urban-centric locale
		STRING	latcod	; //	pos=25	, type=N	, desc=Latitude. Based on the location of the school, the value of LATCOD ranges from 14 to 71. It contains
		STRING	loncod	; //	pos=26	, type=N	, desc=Longitude. Based on the location of the school, the value of LONCOD ranges from -177 to 146. The
		STRING	conum	; //	pos=27	, type=AN	, desc=ANSI county number (two digit ANSI state numeric code + three digits ANSI county code) based on
		STRING	coname	; //	pos=28	, type=AN	, desc=County name based on the location of the
		STRING	cdcode	; //	pos=29	, type=AN	, desc=Congressional district code based on location of administrative office. ANSI numeric code for the
		IFBLOCK(pYear = 2011)
			STRING	cdcode_112	; //	pos=30	, type=AN	, desc=112th Congressional District
		END;
		STRING	bies	; //	pos=30	, type=AN	, desc=Bureau of Indian Education (BIE) school. Indicator of whether or not a school was also reported by the Bureau
		STRING	reconsty	; //	pos=31	, type=AN	, desc=Reconstituted Year. This indicates the latest year that the school was reported as
		STRING	reconstf	; //	pos=32	, type=AN	, desc=Reconstituted Flag.  This flag indicates that the school was restructured, transformed, or
		IFBLOCK(pYear > 2010)
			STRING	smempup	; //	pos=33	, type=AN	, desc=Multi-year edit - School
			STRING	ismempup	; //	pos=34	, type=AN	, desc=Multi-year edit flag- School
			STRING	sftepup	; //	pos=35	, type=AN	, desc=Multi-year edit - School
			STRING	isftepup	; //	pos=36	, type=AN	, desc=Multi-year edit flag - School
			STRING	sfle	; //	pos=37	, type=AN	, desc=Multi-year edit - School Free
			STRING	isfle	; //	pos=38	, type=AN	, desc=Multi-year edit flag - School Free
			STRING	spfemale	; //	pos=39	, type=AN	, desc=Multi-year edit - School
			STRING	ispfemale	; //	pos=40	, type=AN	, desc=Multi-year edit flag - School
			STRING	spwhite	; //	pos=41	, type=AN	, desc=Multi-year edit - School
			STRING	ispwhite	; //	pos=42	, type=AN	, desc=Multi-year edit flag - School
			STRING	spelm	; //	pos=43	, type=AN	, desc=Multi-year edit - School
			STRING	ispelm	; //	pos=44	, type=AN	, desc=Multi-year edit flag - School
		END;
		STRING	fte	; //	pos=45	, type=N	, desc=Total full-time-equivalent classroom teachers.  Full-time equivalency reported to the nearest
		STRING	gslo	; //	pos=46	, type=AN	, desc=School low grade offered. The following codes are
		STRING	gshi	; //	pos=47	, type=AN	, desc=School high grade offered.  The following codes are
		STRING	pkoffrd	; //	pos=48	, type=AN	, desc=Prekindergarten
		STRING	kgoffrd	; //	pos=49	, type=AN	, desc=Kindergarten
		STRING	g01offrd	; //	pos=50	, type=AN	, desc=First grade
		STRING	g02offrd	; //	pos=51	, type=AN	, desc=Second grade
		STRING	g03offrd	; //	pos=52	, type=AN	, desc=Third grade
		STRING	g04offrd	; //	pos=53	, type=AN	, desc=Fourth grade
		STRING	g05offrd	; //	pos=54	, type=AN	, desc=Fifth grade
		STRING	g06offrd	; //	pos=55	, type=AN	, desc=Sixth grade
		STRING	g07offrd	; //	pos=56	, type=AN	, desc=Seventh grade
		STRING	g08offrd	; //	pos=57	, type=AN	, desc=Eighth grade
		STRING	g09offrd	; //	pos=58	, type=AN	, desc=Ninth grade
		STRING	g10offrd	; //	pos=59	, type=AN	, desc=Tenth grade
		STRING	g11offrd	; //	pos=60	, type=AN	, desc=Eleventh grade
		STRING	g12offrd	; //	pos=61	, type=AN	, desc=Twelfth grade
		STRING	ugoffrd	; //	pos=62	, type=AN	, desc=Ungraded
		STRING	level	; //	pos=63	, type=AN	, desc=School level.  The following codes were calculated from the schools corresponding GSLO and GSHI
		STRING	titleistat	; //	pos=64	, type=AN	, desc=Title I School Status. This flag was added to the school file starting in 2010-11. It indicates
		STRING	titlei	; //	pos=65	, type=AN	, desc=Title I Eligible School.  A Title I school designated under appropriate state and federal regulations
		STRING	stitli	; //	pos=66	, type=AN	, desc=School-wide Title I.  A program in which all the pupils in a school are designated under appropriate
		STRING	magnet	; //	pos=67	, type=AN	, desc=Magnet school.  Regardless of the source of funding, a magnet school or program is a special school
		STRING	chartr	; //	pos=68	, type=AN	, desc=Charter school.  A school that provides free elementary and/or secondary education to eligible
		//NB: shared is a reserved keyword in ECL. Renamed to sharedtime.
		STRING	sharedtime	; //	pos=69	, type=AN	, desc=Shared-time school.  A school offering vocational/technical education or other education
		STRING	frelch	; //	pos=70	, type=N	, desc=Count of students eligible to participate in the Free Lunch Program under the National School Lunch
		STRING	redlch	; //	pos=71	, type=N	, desc=Count of students eligible to participate in the Reduced-Price Lunch Program under the National School Lunch
		STRING	totfrl	; //	pos=72	, type=N	, desc=Total of free lunch eligible and reduced-price lunch eligible. The total is only available if both of the
		IFBLOCK(pYear = 2012 OR pYear = 2011 OR pYear = 2010)
			STRING	racecat	; //	pos=73	, type=N	, desc=Race/ethnicities categories indicator.  Indicates whether state reported student enrollment counts by
		END;
		STRING	pk	; //	pos=73	, type=N	, desc=Total prekindergarten
		STRING	ampkm	; //	pos=74	, type=N	, desc=Prekindergarten students - American Indian/Alaska Native -
		STRING	ampkf	; //	pos=75	, type=N	, desc=Prekindergarten students - American Indian/Alaska Native -
		STRING	aspkm	; //	pos=76	, type=N	, desc=Prekindergarten students - Asian -
		STRING	aspkf	; //	pos=77	, type=N	, desc=Prekindergarten students - Asian -
		STRING	hipkm	; //	pos=78	, type=N	, desc=Prekindergarten students - Hispanic -
		STRING	hipkf	; //	pos=79	, type=N	, desc=Prekindergarten students - Hispanic -
		STRING	blpkm	; //	pos=80	, type=N	, desc=Prekindergarten students - Black, non-Hispanic -
		STRING	blpkf	; //	pos=81	, type=N	, desc=Prekindergarten students - Black, non-Hispanic -
		STRING	whpkm	; //	pos=82	, type=N	, desc=Prekindergarten students - White, non-Hispanic -
		STRING	whpkf	; //	pos=83	, type=N	, desc=Prekindergarten students - White, non-Hispanic -
		STRING	hppkm	; //	pos=84	, type=N	, desc=Prekindergarten students - Hawaiian Native/Pacific Islander -
		STRING	hppkf	; //	pos=85	, type=N	, desc=Prekindergarten students - Hawaiian Native/Pacific Islander -
		STRING	trpkm	; //	pos=86	, type=N	, desc=Prekindergarten students - Two or more races -
		STRING	trpkf	; //	pos=87	, type=N	, desc=Prekindergarten students - Two or more races -
		STRING	kg	; //	pos=88	, type=N	, desc=Total kindergarten
		STRING	amkgm	; //	pos=89	, type=N	, desc=Kindergarten students - American Indian/Alaska Native -
		STRING	amkgf	; //	pos=90	, type=N	, desc=Kindergarten students - American Indian/Alaska Native -
		STRING	askgm	; //	pos=91	, type=N	, desc=Kindergarten students - Asian -
		STRING	askgf	; //	pos=92	, type=N	, desc=Kindergarten students - Asian -
		STRING	hikgm	; //	pos=93	, type=N	, desc=Kindergarten students - Hispanic -
		STRING	hikgf	; //	pos=94	, type=N	, desc=Kindergarten students - Hispanic -
		STRING	blkgm	; //	pos=95	, type=N	, desc=Kindergarten students - Black, non-Hispanic -
		STRING	blkgf	; //	pos=96	, type=N	, desc=Kindergarten students - Black, non-Hispanic -
		STRING	whkgm	; //	pos=97	, type=N	, desc=Kindergarten students - White, non-Hispanic -
		STRING	whkgf	; //	pos=98	, type=N	, desc=Kindergarten students - White, non-Hispanic -
		STRING	hpkgm	; //	pos=99	, type=N	, desc=Kindergarten students - Hawaiian Native/Pacific Islander -
		STRING	hpkgf	; //	pos=100	, type=N	, desc=Kindergarten students - Hawaiian Native/Pacific Islander -
		STRING	trkgm	; //	pos=101	, type=N	, desc=Kindergarten students - Two or more races -
		STRING	trkgf	; //	pos=102	, type=N	, desc=Kindergarten students - Two or more races -
		STRING	g01	; //	pos=103	, type=N	, desc=Total grade 1
		STRING	am01m	; //	pos=104	, type=N	, desc=Grade 1 students - American Indian/Alaska Native -
		STRING	am01f	; //	pos=105	, type=N	, desc=Grade 1 students - American Indian/Alaska Native -
		STRING	as01m	; //	pos=106	, type=N	, desc=Grade 1 students - Asian -
		STRING	as01f	; //	pos=107	, type=N	, desc=Grade 1 students - Asian -
		STRING	hi01m	; //	pos=108	, type=N	, desc=Grade 1 students - Hispanic -
		STRING	hi01f	; //	pos=109	, type=N	, desc=Grade 1 students - Hispanic -
		STRING	bl01m	; //	pos=110	, type=N	, desc=Grade 1 students - Black, non-Hispanic -
		STRING	bl01f	; //	pos=111	, type=N	, desc=Grade 1 students - Black, non-Hispanic -
		STRING	wh01m	; //	pos=112	, type=N	, desc=Grade 1 students - White, non-Hispanic -
		STRING	wh01f	; //	pos=113	, type=N	, desc=Grade 1 students - White, non-Hispanic -
		STRING	hp01m	; //	pos=114	, type=N	, desc=Grade 1 students - Hawaiian Native/Pacific Islander -
		STRING	hp01f	; //	pos=115	, type=N	, desc=Grade 1 students - Hawaiian Native/Pacific Islander -
		STRING	tr01m	; //	pos=116	, type=N	, desc=Grade 1 students - Two or more races -
		STRING	tr01f	; //	pos=117	, type=N	, desc=Grade 1 students - Two or more races -
		STRING	g02	; //	pos=118	, type=N	, desc=Total grade 2
		STRING	am02m	; //	pos=119	, type=N	, desc=Grade 2 students - American Indian/Alaska Native -
		STRING	am02f	; //	pos=120	, type=N	, desc=Grade 2 students - American Indian/Alaska Native -
		STRING	as02m	; //	pos=121	, type=N	, desc=Grade 2 students - Asian -
		STRING	as02f	; //	pos=122	, type=N	, desc=Grade 2 students - Asian -
		STRING	hi02m	; //	pos=123	, type=N	, desc=Grade 2 students - Hispanic -
		STRING	hi02f	; //	pos=124	, type=N	, desc=Grade 2 students - Hispanic -
		STRING	bl02m	; //	pos=125	, type=N	, desc=Grade 2 students - Black, non-Hispanic -
		STRING	bl02f	; //	pos=126	, type=N	, desc=Grade 2 students - Black, non-Hispanic -
		STRING	wh02m	; //	pos=127	, type=N	, desc=Grade 2 students - White, non-Hispanic -
		STRING	wh02f	; //	pos=128	, type=N	, desc=Grade 2 students - White, non-Hispanic -
		STRING	hp02m	; //	pos=129	, type=N	, desc=Grade 2 students - Hawaiian Native/Pacific Islander -
		STRING	hp02f	; //	pos=130	, type=N	, desc=Grade 2 students - Hawaiian Native/Pacific Islander -
		STRING	tr02m	; //	pos=131	, type=N	, desc=Grade 2 students - Two or more races -
		STRING	tr02f	; //	pos=132	, type=N	, desc=Grade 2 students - Two or more races -
		STRING	g03	; //	pos=133	, type=N	, desc=Total grade 3
		STRING	am03m	; //	pos=134	, type=N	, desc=Grade 3 students - American Indian/Alaska Native -
		STRING	am03f	; //	pos=135	, type=N	, desc=Grade 3 students - American Indian/Alaska Native -
		STRING	as03m	; //	pos=136	, type=N	, desc=Grade 3 students - Asian -
		STRING	as03f	; //	pos=137	, type=N	, desc=Grade 3 students - Asian -
		STRING	hi03m	; //	pos=138	, type=N	, desc=Grade 3 students - Hispanic -
		STRING	hi03f	; //	pos=139	, type=N	, desc=Grade 3 students - Hispanic -
		STRING	bl03m	; //	pos=140	, type=N	, desc=Grade 3 students - Black, non-Hispanic -
		STRING	bl03f	; //	pos=141	, type=N	, desc=Grade 3 students - Black, non-Hispanic -
		STRING	wh03m	; //	pos=142	, type=N	, desc=Grade 3 students - White, non-Hispanic -
		STRING	wh03f	; //	pos=143	, type=N	, desc=Grade 3 students - White, non-Hispanic -
		STRING	hp03m	; //	pos=144	, type=N	, desc=Grade 3 students - Hawaiian Native/Pacific Islander -
		STRING	hp03f	; //	pos=145	, type=N	, desc=Grade 3 students - Hawaiian Native/Pacific Islander -
		STRING	tr03m	; //	pos=146	, type=N	, desc=Grade 3 students - Two or more races -
		STRING	tr03f	; //	pos=147	, type=N	, desc=Grade 3 students - Two or more races -
		STRING	g04	; //	pos=148	, type=N	, desc=Total grade 4
		STRING	am04m	; //	pos=149	, type=N	, desc=Grade 4 students - American Indian/Alaska Native -
		STRING	am04f	; //	pos=150	, type=N	, desc=Grade 4 students - American Indian/Alaska Native -
		STRING	as04m	; //	pos=151	, type=N	, desc=Grade 4 students - Asian -
		STRING	as04f	; //	pos=152	, type=N	, desc=Grade 4 students - Asian -
		STRING	hi04m	; //	pos=153	, type=N	, desc=Grade 4 students - Hispanic -
		STRING	hi04f	; //	pos=154	, type=N	, desc=Grade 4 students - Hispanic -
		STRING	bl04m	; //	pos=155	, type=N	, desc=Grade 4 students - Black, non-Hispanic -
		STRING	bl04f	; //	pos=156	, type=N	, desc=Grade 4 students - Black, non-Hispanic -
		STRING	wh04m	; //	pos=157	, type=N	, desc=Grade 4 students - White, non-Hispanic -
		STRING	wh04f	; //	pos=158	, type=N	, desc=Grade 4 students - White, non-Hispanic -
		STRING	hp04m	; //	pos=159	, type=N	, desc=Grade 4 students - Hawaiian Native/Pacific Islander -
		STRING	hp04f	; //	pos=160	, type=N	, desc=Grade 4 students - Hawaiian Native/Pacific Islander -
		STRING	tr04m	; //	pos=161	, type=N	, desc=Grade 4 students - Two or more races -
		STRING	tr04f	; //	pos=162	, type=N	, desc=Grade 4 students - Two or more races -
		STRING	g05	; //	pos=163	, type=N	, desc=Total grade 5
		STRING	am05m	; //	pos=164	, type=N	, desc=Grade 5 students - American Indian/Alaska Native -
		STRING	am05f	; //	pos=165	, type=N	, desc=Grade 5 students - American Indian/Alaska Native -
		STRING	as05m	; //	pos=166	, type=N	, desc=Grade 5 students - Asian -
		STRING	as05f	; //	pos=167	, type=N	, desc=Grade 5 students - Asian -
		STRING	hi05m	; //	pos=168	, type=N	, desc=Grade 5 students - Hispanic -
		STRING	hi05f	; //	pos=169	, type=N	, desc=Grade 5 students - Hispanic -
		STRING	bl05m	; //	pos=170	, type=N	, desc=Grade 5 students - Black, non-Hispanic -
		STRING	bl05f	; //	pos=171	, type=N	, desc=Grade 5 students - Black, non-Hispanic -
		STRING	wh05m	; //	pos=172	, type=N	, desc=Grade 5 students - White, non-Hispanic -
		STRING	wh05f	; //	pos=173	, type=N	, desc=Grade 5 students - White, non-Hispanic -
		STRING	hp05m	; //	pos=174	, type=N	, desc=Grade 5 students - Hawaiian Native/Pacific Islander -
		STRING	hp05f	; //	pos=175	, type=N	, desc=Grade 5 students - Hawaiian Native/Pacific Islander -
		STRING	tr05m	; //	pos=176	, type=N	, desc=Grade 5 students - Two or more races -
		STRING	tr05f	; //	pos=177	, type=N	, desc=Grade 5 students - Two or more races -
		STRING	g06	; //	pos=178	, type=N	, desc=Total grade 6
		STRING	am06m	; //	pos=179	, type=N	, desc=Grade 6 students - American Indian/Alaska Native -
		STRING	am06f	; //	pos=180	, type=N	, desc=Grade 6 students - American Indian/Alaska Native -
		STRING	as06m	; //	pos=181	, type=N	, desc=Grade 6 students - Asian -
		STRING	as06f	; //	pos=182	, type=N	, desc=Grade 6 students - Asian -
		STRING	hi06m	; //	pos=183	, type=N	, desc=Grade 6 students - Hispanic -
		STRING	hi06f	; //	pos=184	, type=N	, desc=Grade 6 students - Hispanic -
		STRING	bl06m	; //	pos=185	, type=N	, desc=Grade 6 students - Black, non-Hispanic -
		STRING	bl06f	; //	pos=186	, type=N	, desc=Grade 6 students - Black, non-Hispanic -
		STRING	wh06m	; //	pos=187	, type=N	, desc=Grade 6 students - White, non-Hispanic -
		STRING	wh06f	; //	pos=188	, type=N	, desc=Grade 6 students - White, non-Hispanic -
		STRING	hp06m	; //	pos=189	, type=N	, desc=Grade 6 students - Hawaiian Native/Pacific Islander -
		STRING	hp06f	; //	pos=190	, type=N	, desc=Grade 6 students - Hawaiian Native/Pacific Islander -
		STRING	tr06m	; //	pos=191	, type=N	, desc=Grade 6 students - Two or more races -
		STRING	tr06f	; //	pos=192	, type=N	, desc=Grade 6 students - Two or more races -
		STRING	g07	; //	pos=193	, type=N	, desc=Total grade 7
		STRING	am07m	; //	pos=194	, type=N	, desc=Grade 7 students - American Indian/Alaska Native -
		STRING	am07f	; //	pos=195	, type=N	, desc=Grade 7 students - American Indian/Alaska Native -
		STRING	as07m	; //	pos=196	, type=N	, desc=Grade 7 students - Asian -
		STRING	as07f	; //	pos=197	, type=N	, desc=Grade 7 students - Asian -
		STRING	hi07m	; //	pos=198	, type=N	, desc=Grade 7 students - Hispanic -
		STRING	hi07f	; //	pos=199	, type=N	, desc=Grade 7 students - Hispanic -
		STRING	bl07m	; //	pos=200	, type=N	, desc=Grade 7 students - Black, non-Hispanic -
		STRING	bl07f	; //	pos=201	, type=N	, desc=Grade 7 students - Black, non-Hispanic -
		STRING	wh07m	; //	pos=202	, type=N	, desc=Grade 7 students - White, non-Hispanic -
		STRING	wh07f	; //	pos=203	, type=N	, desc=Grade 7 students - White, non-Hispanic -
		STRING	hp07m	; //	pos=204	, type=N	, desc=Grade 7 students - Hawaiian Native/Pacific Islander -
		STRING	hp07f	; //	pos=205	, type=N	, desc=Grade 7 students - Hawaiian Native/Pacific Islander -
		STRING	tr07m	; //	pos=206	, type=N	, desc=Grade 7 students - Two or more races -
		STRING	tr07f	; //	pos=207	, type=N	, desc=Grade 7 students - Two or more races -
		STRING	g08	; //	pos=208	, type=N	, desc=Total grade 8
		STRING	am08m	; //	pos=209	, type=N	, desc=Grade 8 students - American Indian/Alaska Native -
		STRING	am08f	; //	pos=210	, type=N	, desc=Grade 8 students - American Indian/Alaska Native -
		STRING	as08m	; //	pos=211	, type=N	, desc=Grade 8 students - Asian -
		STRING	as08f	; //	pos=212	, type=N	, desc=Grade 8 students - Asian -
		STRING	hi08m	; //	pos=213	, type=N	, desc=Grade 8 students - Hispanic -
		STRING	hi08f	; //	pos=214	, type=N	, desc=Grade 8 students - Hispanic -
		STRING	bl08m	; //	pos=215	, type=N	, desc=Grade 8 students - Black, non-Hispanic -
		STRING	bl08f	; //	pos=216	, type=N	, desc=Grade 8 students - Black, non-Hispanic -
		STRING	wh08m	; //	pos=217	, type=N	, desc=Grade 8 students - White, non-Hispanic -
		STRING	wh08f	; //	pos=218	, type=N	, desc=Grade 8 students - White, non-Hispanic -
		STRING	hp08m	; //	pos=219	, type=N	, desc=Grade 8 students - Hawaiian Native/Pacific Islander -
		STRING	hp08f	; //	pos=220	, type=N	, desc=Grade 8 students - Hawaiian Native/Pacific Islander -
		STRING	tr08m	; //	pos=221	, type=N	, desc=Grade 8 students - Two or more races -
		STRING	tr08f	; //	pos=222	, type=N	, desc=Grade 8 students - Two or more races -
		STRING	g09	; //	pos=223	, type=N	, desc=Total grade 9
		STRING	am09m	; //	pos=224	, type=N	, desc=Grade 9 students - American Indian/Alaska Native -
		STRING	am09f	; //	pos=225	, type=N	, desc=Grade 9 students - American Indian/Alaska Native -
		STRING	as09m	; //	pos=226	, type=N	, desc=Grade 9 students - Asian -
		STRING	as09f	; //	pos=227	, type=N	, desc=Grade 9 students - Asian -
		STRING	hi09m	; //	pos=228	, type=N	, desc=Grade 9 students - Hispanic -
		STRING	hi09f	; //	pos=229	, type=N	, desc=Grade 9 students - Hispanic -
		STRING	bl09m	; //	pos=230	, type=N	, desc=Grade 9 students - Black, non-Hispanic -
		STRING	bl09f	; //	pos=231	, type=N	, desc=Grade 9 students - Black, non-Hispanic -
		STRING	wh09m	; //	pos=232	, type=N	, desc=Grade 9 students - White, non-Hispanic -
		STRING	wh09f	; //	pos=233	, type=N	, desc=Grade 9 students - White, non-Hispanic -
		STRING	hp09m	; //	pos=234	, type=N	, desc=Grade 9 students - Hawaiian Native/Pacific Islander -
		STRING	hp09f	; //	pos=235	, type=N	, desc=Grade 9 students - Hawaiian Native/Pacific Islander -
		STRING	tr09m	; //	pos=236	, type=N	, desc=Grade 9 students - Two or more races -
		STRING	tr09f	; //	pos=237	, type=N	, desc=Grade 9 students - Two or more races -
		STRING	g10	; //	pos=238	, type=N	, desc=Total grade 10
		STRING	am10m	; //	pos=239	, type=N	, desc=Grade 10 students - American Indian/Alaska Native -
		STRING	am10f	; //	pos=240	, type=N	, desc=Grade 10 students - American Indian/Alaska Native -
		STRING	as10m	; //	pos=241	, type=N	, desc=Grade 10 students - Asian -
		STRING	as10f	; //	pos=242	, type=N	, desc=Grade 10 students - Asian -
		STRING	hi10m	; //	pos=243	, type=N	, desc=Grade 10 students - Hispanic -
		STRING	hi10f	; //	pos=244	, type=N	, desc=Grade 10 students - Hispanic -
		STRING	bl10m	; //	pos=245	, type=N	, desc=Grade 10 students - Black, non-Hispanic -
		STRING	bl10f	; //	pos=246	, type=N	, desc=Grade 10 students - Black, non-Hispanic -
		STRING	wh10m	; //	pos=247	, type=N	, desc=Grade 10 students - White, non-Hispanic -
		STRING	wh10f	; //	pos=248	, type=N	, desc=Grade 10 students - White, non-Hispanic -
		STRING	hp10m	; //	pos=249	, type=N	, desc=Grade 10 students - Hawaiian Native/Pacific Islander -
		STRING	hp10f	; //	pos=250	, type=N	, desc=Grade 10 students - Hawaiian Native/Pacific Islander -
		STRING	tr10m	; //	pos=251	, type=N	, desc=Grade 10 students - Two or more races -
		STRING	tr10f	; //	pos=252	, type=N	, desc=Grade 10 students - Two or more races -
		STRING	g11	; //	pos=253	, type=N	, desc=Total grade 11
		STRING	am11m	; //	pos=254	, type=N	, desc=Grade 11 students - American Indian/Alaska Native -
		STRING	am11f	; //	pos=255	, type=N	, desc=Grade 11 students - American Indian/Alaska Native -
		STRING	as11m	; //	pos=256	, type=N	, desc=Grade 11 students - Asian -
		STRING	as11f	; //	pos=257	, type=N	, desc=Grade 11 students - Asian -
		STRING	hi11m	; //	pos=258	, type=N	, desc=Grade 11 students - Hispanic -
		STRING	hi11f	; //	pos=259	, type=N	, desc=Grade 11 students - Hispanic -
		STRING	bl11m	; //	pos=260	, type=N	, desc=Grade 11 students - Black, non-Hispanic -
		STRING	bl11f	; //	pos=261	, type=N	, desc=Grade 11 students - Black, non-Hispanic -
		STRING	wh11m	; //	pos=262	, type=N	, desc=Grade 11 students - White, non-Hispanic -
		STRING	wh11f	; //	pos=263	, type=N	, desc=Grade 11 students - White, non-Hispanic -
		STRING	hp11m	; //	pos=264	, type=N	, desc=Grade 11 students - Hawaiian Native/Pacific Islander -
		STRING	hp11f	; //	pos=265	, type=N	, desc=Grade 11 students - Hawaiian Native/Pacific Islander -
		STRING	tr11m	; //	pos=266	, type=N	, desc=Grade 11 students - Two or more races -
		STRING	tr11f	; //	pos=267	, type=N	, desc=Grade 11 students - Two or more races -
		STRING	g12	; //	pos=268	, type=N	, desc=Total grade 12
		STRING	am12m	; //	pos=269	, type=N	, desc=Grade 12 students - American Indian/Alaska Native -
		STRING	am12f	; //	pos=270	, type=N	, desc=Grade 12 students - American Indian/Alaska Native -
		STRING	as12m	; //	pos=271	, type=N	, desc=Grade 12 students - Asian -
		STRING	as12f	; //	pos=272	, type=N	, desc=Grade 12 students - Asian -
		STRING	hi12m	; //	pos=273	, type=N	, desc=Grade 12 students - Hispanic -
		STRING	hi12f	; //	pos=274	, type=N	, desc=Grade 12 students - Hispanic -
		STRING	bl12m	; //	pos=275	, type=N	, desc=Grade 12 students - Black, non-Hispanic -
		STRING	bl12f	; //	pos=276	, type=N	, desc=Grade 12 students - Black, non-Hispanic -
		STRING	wh12m	; //	pos=277	, type=N	, desc=Grade 12 students - White, non-Hispanic -
		STRING	wh12f	; //	pos=278	, type=N	, desc=Grade 12 students - White, non-Hispanic -
		STRING	hp12m	; //	pos=279	, type=N	, desc=Grade 12 students - Hawaiian Native/Pacific Islander -
		STRING	hp12f	; //	pos=280	, type=N	, desc=Grade 12 students - Hawaiian Native/Pacific Islander -
		STRING	tr12m	; //	pos=281	, type=N	, desc=Grade 12 students - Two or more races -
		STRING	tr12f	; //	pos=282	, type=N	, desc=Grade 12 students - Two or more races -
		STRING	ug	; //	pos=283	, type=N	, desc=Total ungraded
		STRING	amugm	; //	pos=284	, type=N	, desc=Ungraded students - American Indian/Alaska Native -
		STRING	amugf	; //	pos=285	, type=N	, desc=Ungraded students - American Indian/Alaska Native -
		STRING	asugm	; //	pos=286	, type=N	, desc=Ungraded students - Asian -
		STRING	asugf	; //	pos=287	, type=N	, desc=Ungraded students - Asian -
		STRING	hiugm	; //	pos=288	, type=N	, desc=Ungraded students - Hispanic -
		STRING	hiugf	; //	pos=289	, type=N	, desc=Ungraded students - Hispanic -
		STRING	blugm	; //	pos=290	, type=N	, desc=Ungraded students - Black, non-Hispanic -
		STRING	blugf	; //	pos=291	, type=N	, desc=Ungraded students - Black, non-Hispanic -
		STRING	whugm	; //	pos=292	, type=N	, desc=Ungraded students - White, non-Hispanic -
		STRING	whugf	; //	pos=293	, type=N	, desc=Ungraded students - White, non-Hispanic -
		STRING	hpugm	; //	pos=294	, type=N	, desc=Ungraded students - Hawaiian Native/Pacific Islander -
		STRING	hpugf	; //	pos=295	, type=N	, desc=Ungraded students - Hawaiian Native/Pacific Islander -
		STRING	trugm	; //	pos=296	, type=N	, desc=Ungraded students - Two or more races -
		STRING	trugf	; //	pos=297	, type=N	, desc=Ungraded students - Two or more races -
		STRING	member	; //	pos=298	, type=N	, desc=Total students, all grades:  The reported total membership of the
		STRING	am	; //	pos=299	, type=N	, desc=American Indian/Alaska Native students.  If not reported, this field was calculated by summing the AMALM and AMALF
		STRING	amalm	; //	pos=300	, type=N	, desc=Total students, all grades - American Indian/Alaska Native -
		STRING	amalf	; //	pos=301	, type=N	, desc=Total students, all grades - American Indian/Alaska Native -
		STRING	asian	; //	pos=302	, type=N	, desc=Asian students.  If not reported, this field was calculated by summing the ASALM and ASALF
		STRING	asalm	; //	pos=303	, type=N	, desc=Total students, all grades - Asian -
		STRING	asalf	; //	pos=304	, type=N	, desc=Total students, all grades - Asian -
		STRING	hisp	; //	pos=305	, type=N	, desc=Hispanic students.  If not reported, this field was calculated by summing the HIALM and HIALF
		STRING	hialm	; //	pos=306	, type=N	, desc=Total students, all grades - Hispanic -
		STRING	hialf	; //	pos=307	, type=N	, desc=Total students, all grades - Hispanic -
		STRING	black	; //	pos=308	, type=N	, desc=Black, non-Hispanic students.  If not reported, this field was calculated by summing the BLALM and BLALF
		STRING	blalm	; //	pos=309	, type=N	, desc=Total students, all grades - Black, non-Hispanic -
		STRING	blalf	; //	pos=310	, type=N	, desc=Total students, all grades - Black, non-Hispanic -
		STRING	white	; //	pos=311	, type=N	, desc=White, non-Hispanic students.  If not reported, this field was calculated by summing the WHALM and WHALF
		STRING	whalm	; //	pos=312	, type=N	, desc=Total students, all grades - White, non-Hispanic -
		STRING	whalf	; //	pos=313	, type=N	, desc=Total students, all grades - White, non-Hispanic -
		STRING	pacific	; //	pos=314	, type=N	, desc=Hawaiian Native/Pacific Islander students.  If not reported, this field was calculated by summing the HPALM and HPALF
		STRING	hpalm	; //	pos=315	, type=N	, desc=Total students, all grades - Hawaiian Native/Pacific Islander -
		STRING	hpalf	; //	pos=316	, type=N	, desc=Total students, all grades - Hawaiian Native/Pacific Islander -
		STRING	tr	; //	pos=317	, type=N	, desc=Two or more races students.  If not reported, this field was calculated by summing the TRALM and TRALF
		STRING	tralm	; //	pos=318	, type=N	, desc=Total students, all grades - Two or more races -
		STRING	tralf	; //	pos=319	, type=N	, desc=Total students, all grades - Two or more races -
		STRING	toteth	; //	pos=320	, type=N	, desc=Calculated school race/ethnicity membership: The sum of the fields AM, ASIAN, HISP, BLACK, WHITE, PACIFIC, and
		IFBLOCK(pYear = 2013)
			STRING	virtualstat	; //	pos=321	, type=AN	, desc=Identifies whether the school is a virtual
			STRING	nslpstatus	; //	pos=322	, type=AN	, desc=Represents the National School Lunch Program (NSLP) Status for the school. The accepted values
			STRING	chartauth1	; //	pos=323	, type=AN	, desc=The identifier assigned to the primary public charter school authorizing agency by the
			STRING	chartauth2	; //	pos=324	, type=AN	, desc=The identifier assigned to the secondary public charter school authorizing agency by the
		END;
	END;

END;
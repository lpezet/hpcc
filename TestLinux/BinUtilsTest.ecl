IMPORT Linux.BinUtils;

oCat := BinUtils.cat('/etc/hostname');
ASSERT(oCat, REGEXFIND('^HPCCSystems', line));
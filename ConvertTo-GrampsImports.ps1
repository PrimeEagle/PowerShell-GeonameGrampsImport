# countries
.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "gramps_countries.json" -adminLevel 0

# CN
.\Import-Places.ps1 -csvPath "output-countries-cn.csv" -jsonPath "blank.json" -jsonOutputPath "temp_cn_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-cn-1.csv" -jsonPath "temp_cn_0.json" -jsonOutputPath "gramps_cn_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_cn_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-cn-1.csv" -jsonPath "temp_cn_0.json" -jsonOutputPath "temp_cn_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-cn-2.csv" -jsonPath "temp_cn_1.json" -jsonOutputPath "gramps_cn_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_cn_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-cn-1.csv" -jsonPath "temp_cn_0.json" -jsonOutputPath "temp_cn_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-cn-2.csv" -jsonPath "temp_cn_1.json" -jsonOutputPath "temp_cn_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-cn-3.csv" -jsonPath "temp_cn_12.json" -jsonOutputPath "gramps_cn_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_cn_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-cn-1.csv" -jsonPath "temp_cn_0.json" -jsonOutputPath "temp_cn_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-cn-2.csv" -jsonPath "temp_cn_1.json" -jsonOutputPath "temp_cn_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-cn-3.csv" -jsonPath "temp_cn_12.json" -jsonOutputPath "temp_cn_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-cn-4.csv" -jsonPath "temp_cn_123.json" -jsonOutputPath "gramps_cn_1234.json" -adminLevel 4

# IN
.\Import-Places.ps1 -csvPath "output-countries-in.csv" -jsonPath "blank.json" -jsonOutputPath "temp_in_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-in-1.csv" -jsonPath "temp_in_0.json" -jsonOutputPath "gramps_in_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_in_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-in-1.csv" -jsonPath "temp_in_0.json" -jsonOutputPath "temp_in_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-in-2.csv" -jsonPath "temp_in_1.json" -jsonOutputPath "gramps_in_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_in_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-in-1.csv" -jsonPath "temp_in_0.json" -jsonOutputPath "temp_in_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-in-2.csv" -jsonPath "temp_in_1.json" -jsonOutputPath "temp_in_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-in-3.csv" -jsonPath "temp_in_12.json" -jsonOutputPath "gramps_in_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_in_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-in-1.csv" -jsonPath "temp_in_0.json" -jsonOutputPath "temp_in_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-in-2.csv" -jsonPath "temp_in_1.json" -jsonOutputPath "temp_in_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-in-3.csv" -jsonPath "temp_in_12.json" -jsonOutputPath "temp_in_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-in-4.csv" -jsonPath "temp_in_123.json" -jsonOutputPath "gramps_in_1234.json" -adminLevel 4

# JP
.\Import-Places.ps1 -csvPath "output-countries-jp.csv" -jsonPath "blank.json" -jsonOutputPath "temp_jp_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-jp-1.csv" -jsonPath "temp_jp_0.json" -jsonOutputPath "gramps_jp_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_jp_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-jp-1.csv" -jsonPath "temp_jp_0.json" -jsonOutputPath "temp_jp_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-jp-2.csv" -jsonPath "temp_jp_1.json" -jsonOutputPath "gramps_jp_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_jp_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-jp-1.csv" -jsonPath "temp_jp_0.json" -jsonOutputPath "temp_jp_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-jp-2.csv" -jsonPath "temp_jp_1.json" -jsonOutputPath "temp_jp_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-jp-3.csv" -jsonPath "temp_jp_12.json" -jsonOutputPath "gramps_jp_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_jp_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-jp-1.csv" -jsonPath "temp_jp_0.json" -jsonOutputPath "temp_jp_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-jp-2.csv" -jsonPath "temp_jp_1.json" -jsonOutputPath "temp_jp_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-jp-3.csv" -jsonPath "temp_jp_12.json" -jsonOutputPath "temp_jp_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-jp-4.csv" -jsonPath "temp_jp_123.json" -jsonOutputPath "gramps_jp_1234.json" -adminLevel 4

# MN
.\Import-Places.ps1 -csvPath "output-countries-mn.csv" -jsonPath "blank.json" -jsonOutputPath "temp_mn_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-mn-1.csv" -jsonPath "temp_mn_0.json" -jsonOutputPath "gramps_mn_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_mn_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-mn-1.csv" -jsonPath "temp_mn_0.json" -jsonOutputPath "temp_mn_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-mn-2.csv" -jsonPath "temp_mn_1.json" -jsonOutputPath "gramps_mn_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_mn_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-mn-1.csv" -jsonPath "temp_mn_0.json" -jsonOutputPath "temp_mn_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-mn-2.csv" -jsonPath "temp_mn_1.json" -jsonOutputPath "temp_mn_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-mn-3.csv" -jsonPath "temp_mn_12.json" -jsonOutputPath "gramps_mn_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_mn_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-mn-1.csv" -jsonPath "temp_mn_0.json" -jsonOutputPath "temp_mn_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-mn-2.csv" -jsonPath "temp_mn_1.json" -jsonOutputPath "temp_mn_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-mn-3.csv" -jsonPath "temp_mn_12.json" -jsonOutputPath "temp_mn_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-mn-4.csv" -jsonPath "temp_mn_123.json" -jsonOutputPath "gramps_mn_1234.json" -adminLevel 4

# PH
.\Import-Places.ps1 -csvPath "output-countries-ph.csv" -jsonPath "blank.json" -jsonOutputPath "temp_ph_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-ph-1.csv" -jsonPath "temp_ph_0.json" -jsonOutputPath "gramps_ph_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_ph_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-ph-1.csv" -jsonPath "temp_ph_0.json" -jsonOutputPath "temp_ph_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-ph-2.csv" -jsonPath "temp_ph_1.json" -jsonOutputPath "gramps_ph_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_ph_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-ph-1.csv" -jsonPath "temp_ph_0.json" -jsonOutputPath "temp_ph_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-ph-2.csv" -jsonPath "temp_ph_1.json" -jsonOutputPath "temp_ph_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-ph-3.csv" -jsonPath "temp_ph_12.json" -jsonOutputPath "gramps_ph_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_ph_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-ph-1.csv" -jsonPath "temp_ph_0.json" -jsonOutputPath "temp_ph_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-ph-2.csv" -jsonPath "temp_ph_1.json" -jsonOutputPath "temp_ph_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-ph-3.csv" -jsonPath "temp_ph_12.json" -jsonOutputPath "temp_ph_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-ph-4.csv" -jsonPath "temp_ph_123.json" -jsonOutputPath "gramps_ph_1234.json" -adminLevel 4

# TR
.\Import-Places.ps1 -csvPath "output-countries-tr.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tr_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-tr-1.csv" -jsonPath "temp_tr_0.json" -jsonOutputPath "gramps_tr_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tr_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-tr-1.csv" -jsonPath "temp_tr_0.json" -jsonOutputPath "temp_tr_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-tr-2.csv" -jsonPath "temp_tr_1.json" -jsonOutputPath "gramps_tr_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tr_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-tr-1.csv" -jsonPath "temp_tr_0.json" -jsonOutputPath "temp_tr_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-tr-2.csv" -jsonPath "temp_tr_1.json" -jsonOutputPath "temp_tr_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-tr-3.csv" -jsonPath "temp_tr_12.json" -jsonOutputPath "gramps_tr_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tr_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-tr-1.csv" -jsonPath "temp_tr_0.json" -jsonOutputPath "temp_tr_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-tr-2.csv" -jsonPath "temp_tr_1.json" -jsonOutputPath "temp_tr_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-tr-3.csv" -jsonPath "temp_tr_12.json" -jsonOutputPath "temp_tr_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-tr-4.csv" -jsonPath "temp_tr_123.json" -jsonOutputPath "gramps_tr_1234.json" -adminLevel 4

# TW
.\Import-Places.ps1 -csvPath "output-countries-tw.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tw_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-tw-1.csv" -jsonPath "temp_tw_0.json" -jsonOutputPath "gramps_tw_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tw_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-tw-1.csv" -jsonPath "temp_tw_0.json" -jsonOutputPath "temp_tw_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-tw-2.csv" -jsonPath "temp_tw_1.json" -jsonOutputPath "gramps_tw_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tw_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-tw-1.csv" -jsonPath "temp_tw_0.json" -jsonOutputPath "temp_tw_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-tw-2.csv" -jsonPath "temp_tw_1.json" -jsonOutputPath "temp_tw_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-tw-3.csv" -jsonPath "temp_tw_12.json" -jsonOutputPath "gramps_tw_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_tw_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-tw-1.csv" -jsonPath "temp_tw_0.json" -jsonOutputPath "temp_tw_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-tw-2.csv" -jsonPath "temp_tw_1.json" -jsonOutputPath "temp_tw_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-tw-3.csv" -jsonPath "temp_tw_12.json" -jsonOutputPath "temp_tw_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-tw-4.csv" -jsonPath "temp_tw_123.json" -jsonOutputPath "gramps_tw_1234.json" -adminLevel 4

# US
.\Import-Places.ps1 -csvPath "output-countries-us.csv" -jsonPath "blank.json" -jsonOutputPath "temp_us_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-us-1.csv" -jsonPath "temp_us_0.json" -jsonOutputPath "gramps_us_1.json" -adminLevel 1

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_us_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-us-1.csv" -jsonPath "temp_us_0.json" -jsonOutputPath "temp_us_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-us-2.csv" -jsonPath "temp_us_1.json" -jsonOutputPath "gramps_us_12.json" -adminLevel 2

.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_us_0.json" -adminLevel 0
.\Import-Places.ps1 -csvPath "output-us-1.csv" -jsonPath "temp_us_0.json" -jsonOutputPath "temp_us_1.json" -adminLevel 1
.\Import-Places.ps1 -csvPath "output-us-2.csv" -jsonPath "temp_us_1.json" -jsonOutputPath "temp_us_12.json" -adminLevel 2
.\Import-Places.ps1 -csvPath "output-us-3.csv" -jsonPath "temp_us_12.json" -jsonOutputPath "gramps_us_123.json" -adminLevel 3

#.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "blank.json" -jsonOutputPath "temp_us_0.json" -adminLevel 0
#.\Import-Places.ps1 -csvPath "output-us-1.csv" -jsonPath "temp_us_0.json" -jsonOutputPath "temp_us_1.json" -adminLevel 1
#.\Import-Places.ps1 -csvPath "output-us-2.csv" -jsonPath "temp_us_1.json" -jsonOutputPath "temp_us_12.json" -adminLevel 2
#.\Import-Places.ps1 -csvPath "output-us-3.csv" -jsonPath "temp_us_12.json" -jsonOutputPath "temp_us_123.json" -adminLevel 3
#.\Import-Places.ps1 -csvPath "output-us-4.csv" -jsonPath "temp_us_123.json" -jsonOutputPath "gramps_us_1234.json" -adminLevel 4

Remove-Item temp_*.json
# countries
.\Import-Places.ps1 -csvPath "output-countries-0.csv" -jsonPath "whlc.json" -jsonOutputPath "whlcoutput.json"

# CN
.\Import-Places.ps1 -csvPath "output-cn-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_cn_1.json"
.\Import-Places.ps1 -csvPath "output-cn-2.csv" -jsonPath "temp_cn_1.json" -jsonOutputPath "temp_cn_12.json"
.\Import-Places.ps1 -csvPath "output-cn-3.csv" -jsonPath "temp_cn_12.json" -jsonOutputPath "whlcoutput.json"

# IN
.\Import-Places.ps1 -csvPath "output-in-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_in_1.json"
.\Import-Places.ps1 -csvPath "output-in-2.csv" -jsonPath "temp_in_1.json" -jsonOutputPath "temp_in_12.json"
.\Import-Places.ps1 -csvPath "output-in-3.csv" -jsonPath "temp_in_12.json" -jsonOutputPath "whlcoutput.json"

# JP
.\Import-Places.ps1 -csvPath "output-jp-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_jp_1.json"
.\Import-Places.ps1 -csvPath "output-jp-2.csv" -jsonPath "temp_jp_1.json" -jsonOutputPath "temp_jp_12.json"
.\Import-Places.ps1 -csvPath "output-jp-3.csv" -jsonPath "temp_jp_12.json" -jsonOutputPath "whlcoutput.json"

# MN
.\Import-Places.ps1 -csvPath "output-mn-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_mn_1.json"
.\Import-Places.ps1 -csvPath "output-mn-2.csv" -jsonPath "temp_mn_1.json" -jsonOutputPath "temp_mn_12.json"
.\Import-Places.ps1 -csvPath "output-mn-3.csv" -jsonPath "temp_mn_12.json" -jsonOutputPath "whlcoutput.json"

# PH
.\Import-Places.ps1 -csvPath "output-ph-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_ph_1.json"
.\Import-Places.ps1 -csvPath "output-ph-2.csv" -jsonPath "temp_ph_1.json" -jsonOutputPath "temp_ph_12.json"
.\Import-Places.ps1 -csvPath "output-ph-3.csv" -jsonPath "temp_ph_12.json" -jsonOutputPath "whlcoutput.json"

# TR
.\Import-Places.ps1 -csvPath "output-tr-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_tr_1.json"
.\Import-Places.ps1 -csvPath "output-tr-2.csv" -jsonPath "temp_tr_1.json" -jsonOutputPath "temp_tr_12.json"
.\Import-Places.ps1 -csvPath "output-tr-3.csv" -jsonPath "temp_tr_12.json" -jsonOutputPath "whlcoutput.json"

# TW
.\Import-Places.ps1 -csvPath "output-tw-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_tw_1.json"
.\Import-Places.ps1 -csvPath "output-tw-2.csv" -jsonPath "temp_tw_1.json" -jsonOutputPath "temp_tw_12.json"
.\Import-Places.ps1 -csvPath "output-tw-3.csv" -jsonPath "temp_tw_12.json" -jsonOutputPath "whlcoutput.json"

# US
.\Import-Places.ps1 -csvPath "output-us-1.csv" -jsonPath "whlcoutput.json" -jsonOutputPath "temp_us_1.json"
.\Import-Places.ps1 -csvPath "output-us-2.csv" -jsonPath "temp_us_1.json" -jsonOutputPath "temp_us_12.json"
.\Import-Places.ps1 -csvPath "output-us-3.csv" -jsonPath "temp_us_12.json" -jsonOutputPath "whlcoutput.json"

Remove-Item temp_*.json
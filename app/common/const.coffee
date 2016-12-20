exports.stations =
  # Skopje
  Centar:       { name: "Центар",       region: 'SkopjeRegion' }
  Karpos:       { name: "Карпош",       region: 'SkopjeRegion' }
  Lisice:       { name: "Лисиче",       region: 'SkopjeRegion' }
  GaziBaba:     { name: "Гази Баба",    region: 'SkopjeRegion' }
  Rektorat:     { name: "Ректорат",     region: 'SkopjeRegion' }
  Miladinovci:  { name: "Миладиновци",  region: 'SkopjeRegion' }
  Mrsevci:      { name: "Мршевци",      region: 'SkopjeRegion' }
  
  # Western Region
  Bitola1:    { name: "Битола 1",   region: 'WesternRegion' }
  Bitola2:    { name: "Битола 2",   region: 'WesternRegion' }
  Kicevo:     { name: "Кичево",     region: 'WesternRegion' }
  Lazaropole: { name: "Лазарополе", region: 'WesternRegion' }
  Tetovo:     { name: "Тетово",     region: 'WesternRegion' }

  # Eastern Region
  Veles1:     { name: "Велес 1",    region: 'EasternRegion' }
  Veles2:     { name: "Велес 2",    region: 'EasternRegion' }
  Kocani:     { name: "Кочани",     region: 'EasternRegion' }
  Kavadarci:  { name: "Кавадарци",  region: 'EasternRegion' }
  Kumanovo:   { name: "Куманово",   region: 'EasternRegion' }

  # Regions
  SkopjeRegion:   { name: "Агломерација Скопски pегион",  id: 0 }
  WesternRegion:  { name: "Западна зона",                 id: 1 }
  EasternRegion:  { name: "Источна зона",                 id: 2 }

exports.parameters =
  CO:
    name:       "Јаглерод Моноксид (CO)"
    unit:       "mg/m³" # &#179;	
    shortName:  "CO"
    shortNameNoSubscript: "CO"
    levels: # 8 hrs
      good:           { low:  0, high:   1 }
      moderate:       { low:  1, high:   2 }
      sensitive:      { low:  2, high:  10 }
      unhealthy:      { low: 10, high:  17 }
      veryUnhealthy:  { low: 17, high:  34 }
      hazardous:      { low: 34, high: 100 }
  NO2:
    name:       "Азот Диоксид (NO2)"
    unit:       "µg/m³" # &#179;
    shortName:  "NO₂" # &#8322;
    shortNameNoSubscript: "NO2"
    levels: # 24 hrs
      good:           { low:   0, high:   41 }
      moderate:       { low:  41, high:   81 }
      sensitive:      { low:  81, high:  181 }
      unhealthy:      { low: 181, high:  281 }
      veryUnhealthy:  { low: 281, high:  401 }
      hazardous:      { low: 401, high: 1000 }
  O3:
    name:       "Озон (O3)"
    unit:       "µg/m³" # &#179;
    shortName:  "O₃" # &#8323;
    shortNameNoSubscript: "O3"
    levels: # 8 hrs
      good:           { low:    0, high:   51 }
      moderate:       { low:   52, high:  101 }
      sensitive:      { low:  101, high:  169 }
      unhealthy:      { low:  169, high:  209 }
      veryUnhealthy:  { low:  209, high:  749 }
      hazardous:      { low:  749, high: 2000 }
  PM10:
    name:       "Суспендирани Честички (PM10)"
    unit:       "µg/m³" # &#179;
    shortName:  "PM₁₀" # &#8321;&#8320;
    shortNamNoSubscript: "PM10"
    levels:  # 24 hrs
      good:           { low:   0, high:   51 }
      moderate:       { low:  51, high:  101 }
      sensitive:      { low: 101, high:  251 }
      unhealthy:      { low: 251, high:  351 }
      veryUnhealthy:  { low: 351, high:  431 }
      hazardous:      { low: 431, high: 2000 }
  PM10D:
    name:       "Суспендирани Честички (PM10) Дневно"
    unit:       "µg/m³" # &#179;
    shortName:  "PM₁₀" # &#8321;&#8320;
    shortNameNoSubscript: "PM10D"
    levels: # 24 hrs
      good:           { low:   0, high:   51 }
      moderate:       { low:  51, high:  101 }
      sensitive:      { low: 101, high:  251 }
      unhealthy:      { low: 251, high:  351 }
      veryUnhealthy:  { low: 351, high:  431 }
      hazardous:      { low: 431, high: 2000 }
  PM25:
    name:       "Суспендирани Честички (PM2.5)"
    unit:       "µg/m³" # &#179;
    shortName:  "PM₂.₅" # &#8322;.&#8325;
    shortNameNoSubscript: "PM2.5"
    levels: # 24 hrs
      good:           { low:   0, high:   31 }
      moderate:       { low:  31, high:   61 }
      sensitive:      { low:  61, high:   91 }
      unhealthy:      { low:  91, high:  121 }
      veryUnhealthy:  { low: 121, high:  251 }
      hazardous:      { low: 251, high: 2000 }
  SO2:
    name:       "Сулфур Диоксид (SO2)"
    unit:       "µg/m³" # &#179;
    shortName:  "SO₂" # &#8322;
    shortNameNoSubscript: "SO2"
    levels: # 24 hrs
      good:           { low:    0, high:   41 }
      moderate:       { low:   41, high:   81 }
      sensitive:      { low:   81, high:  381 }
      unhealthy:      { low:  381, high:  801 }
      veryUnhealthy:  { low:  801, high: 1601 }
      hazardous:      { low: 1601, high: 5000 }


exports.MAKE_GRAPH_PATH = "http://airquality.moepp.gov.mk/graphs/site/pages/MakeGraph.php"
exports.METADATA_PATH   = "http://airquality.moepp.gov.mk/graphs/site/pages/Metadata.class.php"


-- etldoc: layer_area_name[shape=record fillcolor=lightpink,
-- etldoc:     style="rounded,filled", label="layer_area_name | <z17_> z17+" ] ;

DROP FUNCTION IF EXISTS layer_area_name(geometry, integer, numeric);
DROP FUNCTION IF EXISTS layer_area_name(geometry, integer);
CREATE FUNCTION layer_area_name(bbox geometry, zoom_level integer)
RETURNS TABLE(geometry geometry, name text, name_en text, name_de text, level numeric) AS $$
   -- etldoc: osm_area_point -> layer_area_name:z17_
   SELECT geometry, COALESCE(NULLIF(name, ''), ref) AS name, name_en, name_de, unnest(expand_levels(level, repeat_on)) AS level
    FROM osm_area_point
    WHERE zoom_level >= 17 AND geometry && bbox;

$$ LANGUAGE SQL IMMUTABLE;

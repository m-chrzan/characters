-- Calculates the given attributes modifier (5th edition rules)
CREATE OR REPLACE FUNCTION modifier(char_id INTEGER, attribute_name CHAR)
RETURNS integer AS $mod$
DECLARE
    attribute_value INTEGER;
    mod_value INTEGER;
BEGIN
    SELECT A.value INTO attribute_value
    FROM ChAttribute A
    WHERE A.character_id = char_id AND A.name = attribute_name;

    mod_value = (attribute_value - 10) / 2; 

    RETURN mod_value;
END;
$mod$ LANGUAGE plpgsql;

-- Calculates the character's proficiency bonus based on level (5th edition rules)
CREATE OR REPLACE FUNCTION proficiency_bonus(char_id INTEGER)
RETURNS INTEGER AS $prof$
DECLARE
    level INTEGER;
    prof_bonus INTEGER;
BEGIN
    SELECT A.value INTO level
    FROM ChAttribute A
    WHERE A.character_id = char_id AND A.name ILIKE 'level';

    IF level IS NULL THEN
        RAISE EXCEPTION
            $$Character's level unknown. Can't calculate proficinecy bonus$$;
    END IF;

    prof_bonus = ((level - 1) / 4) + 2;

    RETURN prof_bonus;
END;
$prof$ LANGUAGE plpgsql;

-- Returns the id's and names of items owned by the given character
CREATE OR REPLACE FUNCTION inventory(char_id INTEGER)
RETURNS TABLE (item_id INTEGER, item_name TEXT) AS $inv$
BEGIN
    RETURN QUERY SELECT I.id, I.name
    FROM Item I
    WHERE I.character_id = char_id;
END;
$inv$ LANGUAGE plpgsql;

-- Returns all abilities and attributes describing the given character
CREATE OR REPLACE FUNCTION character_info(char_id INTEGER)
RETURNS TABLE (name TEXT, value INTEGER, description TEXT) AS $ch_info$
BEGIN
    RETURN QUERY
        (SELECT A.name, A.value, NULL FROM ChAttribute A
            WHERE A.character_id = char_id)
        UNION
        (SELECT A.name, NULL, A.description FROM ChAbility A
            WHERE A.character_id = char_id);
END;
$ch_info$ LANGUAGE plpgsql;

-- Returns all abilities and attributes describing the given item
CREATE OR REPLACE FUNCTION item_info(it_id INTEGER)
RETURNS TABLE (name TEXT, value INTEGER, description TEXT) AS $it_info$
BEGIN
    RETURN QUERY
        (SELECT A.name, A.value, NULL FROM ItAttribute A
            WHERE A.item_id = it_id)
        UNION
        (SELECT A.name, NULL, A.description FROM ItAbility A
            WHERE A.item_id = it_id);
END;
$it_info$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_dnd_character(char_id INTEGER)
RETURNS BOOLEAN AS $is_dnd$
DECLARE
    is_dnd BOOLEAN;    
BEGIN
    SELECT 7 = COUNT(*) INTO is_dnd
         FROM ChAttribute
         WHERE character_id = char_id AND name SIMILAR TO
        'strength|dexterity|constitution|intelligence|wisdom|charisma|level';

    RETURN is_dnd;
END;
$is_dnd$ LANGUAGE plpgsql;

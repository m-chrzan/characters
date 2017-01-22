INSERT INTO Character VALUES (0, 'Iliphar Heileth', 'Elf');
    INSERT INTO ChAttribute VALUES ('level', 0, 2);
    INSERT INTO ChAttribute VALUES ('strength', 0, 16);
    INSERT INTO ChAttribute VALUES ('dexterity', 0, 14);
    INSERT INTO ChAttribute VALUES ('constitution', 0, 11);
    INSERT INTO ChAttribute VALUES ('intelligence', 0, 12);
    INSERT INTO ChAttribute VALUES ('wisdom', 0, 13);
    INSERT INTO ChAttribute VALUES ('charisma', 0, 13);
    INSERT INTO ChAbility VALUES ('class', 0, 'fighter');

    INSERT INTO Item VALUES (0, 'short sword', 0);
        INSERT INTO ItAttribute VALUES ('damage die', 0, 8);

    INSERT INTO Item VALUES (2, 'leather armor', 0);

INSERT INTO Character VALUES (1, 'Adresin Paran', 'Elf');
    INSERT INTO ChAttribute VALUES ('level', 1, 5);
    INSERT INTO ChAttribute VALUES ('strength', 1, 11);
    INSERT INTO ChAttribute VALUES ('dexterity', 1, 17);
    INSERT INTO ChAttribute VALUES ('constitution', 1, 10);
    INSERT INTO ChAttribute VALUES ('intelligence', 1, 10);
    INSERT INTO ChAttribute VALUES ('wisdom', 1, 15);
    INSERT INTO ChAttribute VALUES ('charisma', 1, 15);
    INSERT INTO ChAbility VALUES ('class', 1, 'ranger');

    INSERT INTO Item VALUES (1, 'longbow', 1);
        INSERT INTO ItAttribute VALUES ('damage die', 1, 4);
        INSERT INTO ItAttribute VALUES ('range', 1, 120);

    INSERT INTO Item VALUES (3, 'leather armor', 1);

INSERT INTO Character VALUES (2, 'Uldrem Cragmace', 'Dwarf');
    INSERT INTO ChAttribute VALUES ('level', 2, 7);
    INSERT INTO ChAttribute VALUES ('strength', 2, 18);
    INSERT INTO ChAttribute VALUES ('dexterity', 2, 10);
    INSERT INTO ChAttribute VALUES ('constitution', 2, 14);
    INSERT INTO ChAttribute VALUES ('intelligence', 2, 11);
    INSERT INTO ChAttribute VALUES ('wisdom', 2, 12);
    INSERT INTO ChAttribute VALUES ('charisma', 2, 10);
    INSERT INTO ChAbility VALUES ('class', 2, 'cleric');


INSERT INTO Character VALUES (3, 'Cailean Rathais', 'Human');
    INSERT INTO ChAttribute VALUES ('level', 3, 18);
    INSERT INTO ChAttribute VALUES ('strength', 3, 14);
    INSERT INTO ChAttribute VALUES ('dexterity', 3, 8);
    INSERT INTO ChAttribute VALUES ('constitution', 3, 16);
    INSERT INTO ChAttribute VALUES ('intelligence', 3, 11);
    INSERT INTO ChAttribute VALUES ('wisdom', 3, 16);
    INSERT INTO ChAttribute VALUES ('charisma', 3, 8);
    INSERT INTO ChAbility VALUES ('class', 3, 'paladin');

    INSERT INTO Item VALUES (4, 'vorpal sword', 3);
        INSERT INTO ItAttribute VALUES ('attack bonus', 4, 3);
        INSERT INTO ItAttribute VALUES ('damage bonus', 4, 3);
        INSERT INTO ItAttribute VALUES ('damage die', 4, 10);
        INSERT INTO ItAbility VALUES ('ignores resistance to slashing damage', 4);
        INSERT INTO ItAbility VALUES
        ('behead', 4, $$On a roll of 20, cut off one of the creature's heads$$);

INSERT INTO Character VALUES (4, 'Owlbear', 'Owlbear');
    INSERT INTO ChAttribute VALUES ('challenge', 4, 3);
    INSERT INTO ChAttribute VALUES ('strength', 4, 20);
    INSERT INTO ChAttribute VALUES ('dexterity', 4, 12);
    INSERT INTO ChAttribute VALUES ('constitution', 4, 17);
    INSERT INTO ChAttribute VALUES ('intelligence', 4, 3);
    INSERT INTO ChAttribute VALUES ('wisdom', 4, 12);
    INSERT INTO ChAttribute VALUES ('charisma', 4, 7);
    INSERT INTO ChAttribute VALUES ('armor class', 4, 13);

    INSERT INTO ChAbility VALUES ('Keen sight', 4,
        'Advantage on Wisdom (Perception) checks that rely on sight');
    INSERT INTO ChAbility VALUES ('Keen smell', 4,
        'Advantage on Wisdom (Perception) checks that rely on smell');

    INSERT INTO Item VALUES (5, 'beak', 4);
        INSERT INTO ItAttribute VALUES ('damage die', 5, 10);
        INSERT INTO ItAbility VALUES ('damage type', 5, 'piercing');

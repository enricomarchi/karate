DROP VIEW IF EXISTS `riepilogo_iscrizioni`;
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `riepilogo_iscrizioni` AS
    SELECT 
        `iscrizioni`.`id_iscrizione` AS `id_iscrizione`,
        `iscrizioni`.`NAZIONALITÀ` AS nazionalità,
        `iscrizioni`.`N CLUB` AS id_club,
        `iscrizioni`.`CLUB` AS club,
        `iscrizioni`.`N` AS id_atleta,
        `iscrizioni`.`COGNOME` AS cognome,
        `iscrizioni`.`NOME` AS nome,
        `iscrizioni`.`DATA DI NASCITA (AAAA-MM-GG)` AS data_nascita,
        `iscrizioni`.`SESSO` AS sesso,
        `iscrizioni`.`PESO / KG` AS peso_kg,
        `iscrizioni`.`ALTEZZA / CM` AS altezza_cm,
        `iscrizioni`.`Kyu/Kup` AS kyu_kup,
        `iscrizioni`.`Dan` AS dan,
        `iscrizioni`.`SQUADRE` AS squadre,
		`iscrizioni`.`N.1` AS id_categoria,
        `iscrizioni`.`CATEGORIA` AS categoria,
        CASE
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%KATA%' THEN 'KATA'
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%KUMITE%' THEN 'KUMITE'
            ELSE NULL
        END AS `kata_kumite`,
        CASE
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%INDIVIDUAL%' THEN 'INDIVIDUAL'
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%TEAM%' THEN 'TEAM'
            ELSE NULL
        END AS `individual_team`,
        CASE
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%MIXED%' THEN 'MIXED'
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%FEMALE%' THEN 'FEMALE'
            WHEN `iscrizioni`.`CATEGORIA` LIKE '%MALE%' THEN 'MALE'
            ELSE NULL
        END AS `male_female`
    FROM
        iscrizioni
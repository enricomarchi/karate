CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `iscrizioni_multiple` AS
    SELECT 
        `riepilogo_iscrizioni`.`club` AS `club`,
        `riepilogo_iscrizioni`.`cognome` AS `cognome`,
        `riepilogo_iscrizioni`.`nome` AS `nome`,
        `riepilogo_iscrizioni`.`data_nascita` AS `data_nascita`,
        `riepilogo_iscrizioni`.`sesso` AS `sesso`,
        `riepilogo_iscrizioni`.`peso_kg` AS `peso_kg`,
        `riepilogo_iscrizioni`.`kyu_kup` AS `kyu_kup`,
        `riepilogo_iscrizioni`.`dan` AS `dan`,
        `riepilogo_iscrizioni`.`squadre` AS `squadre`,
        `riepilogo_iscrizioni`.`categoria` AS `categoria`
    FROM
        `riepilogo_iscrizioni`
    WHERE
        (`riepilogo_iscrizioni`.`id_atleta` IN (SELECT 
                `riepilogo_iscrizioni`.`id_atleta`
            FROM
                `riepilogo_iscrizioni`
            GROUP BY `riepilogo_iscrizioni`.`id_atleta`
            HAVING (COUNT(`riepilogo_iscrizioni`.`id_atleta`) > 1))
            AND (`riepilogo_iscrizioni`.`kata_kumite` = 'KUMITE'))
    ORDER BY `riepilogo_iscrizioni`.`club` , `riepilogo_iscrizioni`.`cognome` , `riepilogo_iscrizioni`.`nome`
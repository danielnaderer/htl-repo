-- ====================================================
-- AUFGABE 1 INNER JOIN
-- ====================================================

select s.Name, k.Bezeichnung
from whl.SCHUELER as s
inner join whl.KLASSE K on s.KlassenID = K.KlassenID;

-- ====================================================
-- AUFGABE 2 - JOIN ÜBER DREI TABELLEN
-- ====================================================

select u.Fach, l.Name, k.Bezeichnung
from whl.UNTERRICHT as u
join whl.LEHRER as l
    on u.LehrerID = l.LehrerID
join whl.Klasse as k
    on u.KlassenID = k.KlassenID;

-- ====================================================
-- AUFGABE 3 - JOIN MIT WHERE
-- ====================================================

select s.Name
from whl.SCHUELER as s
join whl.KLASSE as k
    on s.KlassenID = k.KlassenID
where k.Bezeichnung = '4AHIF';

-- ====================================================
-- AUFGABE 4 - LEFT JOIN
-- ====================================================

select l.Name, u.Fach
from whl.LEHRER as l
left join whl.UNTERRICHT as u
    on l.LehrerID = u.LehrerID;

-- ====================================================
-- AUFGABE 5 - EXISTS
-- ====================================================

select l.Name
from whl.LEHRER as l
where exists (
    select 1
    from whl.UNTERRICHT as u
    where l.LehrerID = u.LehrerID
);

-- ====================================================
-- AUFGABE 6 - EXISTS MIT BEDINGUNG
-- ====================================================

select l.Name
from whl.LEHRER as l
where exists (
    select 1
    from whl.UNTERRICHT as u
    where l.LehrerID = u.LehrerID
    and u.Fach = 'DBI'
);

-- ====================================================
-- AUFGABE 7 - NOT EXISTS
-- ====================================================

select l.Name
from whl.LEHRER as l
where not exists (
    select 1
    from whl.UNTERRICHT as u
    where l.LehrerID = u.LehrerID
);

-- ====================================================
-- AUFGABE 8 - EXISTS
-- ====================================================

select k.Bezeichnung
from whl.KLASSE as k
where exists (
    select 1
    from whl.SCHUELER as s
    where k.KlassenID = s.KlassenID
);

-- ====================================================
-- AUFGABE 9 - JOIN UND EXISTS
-- ====================================================

select s.Name, k.Bezeichnung
from whl.SCHUELER as s
join whl.KLASSE K on s.KlassenID = K.KlassenID
where exists (
    select 1
    from whl.UNTERRICHT as u
    where u.KlassenID = K.KlassenID
    and u.Fach = 'DBI'
);

-- ====================================================
-- AUFGABE 10 - NOT EXISTS
-- ====================================================

select k.Bezeichnung
from whl.KLASSE as k
where not exists (
    select 1
    from whl.UNTERRICHT as u
    where k.KlassenID = u.KlassenID
    and u.Fach = 'DBI'
);

-- ====================================================
-- AUFGABE 11 - CTE (Common Table Expression)
-- ====================================================

with SchuelerProKlasse as (
    select KlassenID, count(*) as AnzahlSchueler
    from whl.SCHUELER
    group by KlassenID
)
select k.Bezeichnung, spk.AnzahlSchueler
from SchuelerProKlasse as spk
join whl.KLASSE as k
    on spk.KlassenID = k.KlassenID
where spk.AnzahlSchueler > 20;

-- ====================================================
-- AUFGABE 12 - CTE + JOIN + EXISTS + NOT EXISTS
-- ====================================================

with LehrerKlassen as (
    select LehrerID, count(distinct KlassenID) as AnzahlKlassen
    from whl.UNTERRICHT
    group by LehrerID
)
select l.Name, lk.AnzahlKlassen
from whl.LEHRER as l
join LehrerKlassen as lk
    on l.LehrerID = lk.LehrerID
where lk.AnzahlKlassen >= 2
and exists (
    select 1
    from whl.UNTERRICHT as u
    where u.LehrerID = l.LehrerID
      and u.Fach = 'DBI'
)
and not exists (
    select 1
    from whl.UNTERRICHT as u
    where u.LehrerID = l.LehrerID
      and not exists (
          select 1
          from whl.SCHUELER as s
          where s.KlassenID = u.KlassenID
      )
);
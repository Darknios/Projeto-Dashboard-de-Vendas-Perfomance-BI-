create database Testmusic;
use Testmusic;

CREATE TABLE music_test (
    id INT PRIMARY KEY,
    titulo VARCHAR(255),
    artista VARCHAR(255),
    genero_principal VARCHAR(100),
    ano SMALLINT,
    streams_mil INT,
    energia DECIMAL(5,2),
    dancabilidade DECIMAL(5,2),
    loudness_dB DECIMAL(5,2),
    vivacidade DECIMAL(5,2),
    valencia DECIMAL(5,2),
    duracao_seg INT,
    acusticidade DECIMAL(5,2),
    fala DECIMAL(5,2),
    popularidade SMALLINT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\SeuUsuario\\Desktop\\Music Test.csv'
INTO TABLE music_test;

select * from music_test;

/*Cálculo do total de streams por gênero*/
SELECT 
    genero_principal,
    SUM(streams_mil) AS total_streams_mil
FROM music_test
GROUP BY genero_principal
ORDER BY total_streams_mil DESC;

/*Cálculo da média de streams por gênero*/
SELECT 
    genero_principal,
    AVG(streams_mil) AS media_streams_mil
FROM music_test
GROUP BY genero_principal
ORDER BY media_streams_mil DESC;

/*Verificação do total de streams por artista em cada ano*/
SELECT 
    artista,
    ano,
    SUM(streams_mil) AS total_streams_mil
FROM music_test
GROUP BY artista, ano
ORDER BY artista, ano;

/*Consulta da tabela completa anonimizando as colunas de artista e gênero (utilizando IDs)*/
SELECT 
    m.id,
    m.titulo,
    a.artista_id,
    g.genero_id,
    m.ano,
    m.streams_mil,
    m.energia,
    m.dancabilidade,
    m.loudness_dB,
    m.vivacidade,
    m.valencia,
    m.duracao_seg,
    m.acusticidade,
    m.fala,
    m.popularidade
FROM music_test m

JOIN (
    SELECT artista, @a:=@a+1 AS artista_id
    FROM (SELECT DISTINCT artista FROM music_test) t
    JOIN (SELECT @a:=0) r
) a ON m.artista = a.artista

JOIN (
    SELECT genero_principal, @g:=@g+1 AS genero_id
    FROM (SELECT DISTINCT genero_principal FROM music_test) t
    JOIN (SELECT @g:=0) r
) g ON m.genero_principal = g.genero_principal

ORDER BY m.id;


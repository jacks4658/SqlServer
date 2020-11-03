--CREATE TABLE Testes.dbo.Cliente (
 --   Id_Cliente INT IDENTITY(1, 1),
   -- Nome VARCHAR(100),
   -- Data_Nascimento DATETIME,
   -- Salario FLOAT
--)
 
--INSERT INTO Testes.dbo.Cliente
--VALUES 
    --('João', '1981-05-14', 4521),
   -- ('Marcos', '1975-01-07', 1478.58),
    --('André', '1962-11-11', 7151.45),
   -- ('Simão', '1991-12-18', 2584.97),
   -- ('Pedro', '1986-11-20', 987.52),
  --  ('Paulo', '1974-08-04', 6259.14),
  --  ('José', '1979-09-01', 5272.13)
 
 
--SELECT * FROM Testes.dbo.Cliente

--CRIANDO A TRIGGER

IF (OBJECT_ID('CADASTRO_Log') IS NOT NULL) DROP TABLE CADASTRO_LOG
CREATE TABLE CADASTRO_Log (
    Id_LOG INT IDENTITY(1, 1),
    Dt_Atualizacao DATETIME DEFAULT GETDATE(),
    [Login] VARCHAR(100),
    Hostname VARCHAR(100),
    ACAO VARCHAR(20),
 
    -- Dados da tabela original
    Id INT,
    RECEBIDO VARCHAR(100),
    CODIGO VARCHAR(50),
	ENDERECO VARCHAR(90),
	DESCRICAO VARCHAR(80),
	PROPRIETARIO VARCHAR(50)
)
GO
 
IF ((SELECT COUNT(*) FROM sys.triggers WHERE name = 'trgHistorico_CADASTRO' AND parent_id = OBJECT_ID('CADASTRO')) > 0) DROP TRIGGER trgHistorico_Cliente
GO
 
CREATE TRIGGER trgHistorico_CADASTRO ON CADASTRO -- Tabela que a trigger será associada
AFTER INSERT, UPDATE, DELETE AS
BEGIN
    
    SET NOCOUNT ON
 
    DECLARE 
        @Login VARCHAR(100) = SYSTEM_USER, 
        @HostName VARCHAR(100) = HOST_NAME(),
        @Data DATETIME =  DATEADD(HOUR, -3, GETDATE())
        
 
    IF (EXISTS(SELECT * FROM Inserted) AND EXISTS (SELECT * FROM Deleted))
    BEGIN
        
        INSERT INTO CADASTRO_Log
        SELECT @Data, @Login, @HostName, 'NOVO', *
        FROM Inserted
 
    END
    ELSE BEGIN
 
        IF (EXISTS(SELECT * FROM Inserted))
        BEGIN
 
            INSERT INTO CADASTRO_Log
            SELECT @Data, @Login, @HostName, 'CADASTRADO', *
            FROM Inserted
 
        END
        ELSE BEGIN
 
            INSERT INTO CADASTRO_Log
            SELECT @Data, @Login, @HostName, 'ENTREGUE', *
            FROM Deleted
 
        END
 
    END
 
END


---INSERINDO ALTERAÇOES

INSERT INTO CADASTRO
VALUES ('Bartolomeu', '4585124752BR','ANDORINHA','UM PACOTE','MARCIANO')
 
--UPDATE CADASTRO
--SET Salario = Salario * 1.5
--WHERE Nome = 'Bartolomeu'
 
--DELETE FROM CADASTRO
--WHERE Nome = 'André'
 
--UPDATE CADASTRO
--SET Salario = Salario * 1.1
--WHERE Id_Cliente = 2
 
--UPDATE CADASTRO
--SET Salario = 10, Nome = 'Judas Iscariodes', Data_Nascimento = '06/06/2066'
--WHERE Id_Cliente = 1
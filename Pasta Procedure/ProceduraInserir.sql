/****** Object:  StoredProcedure [dbo].[InsetarCadastro]    Script Date: 06/07/2020 22:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--------------------------INSERTAR 
ALTER procedure [dbo].[InsetarCadastro]
@recebido varchar (50),
@codigo varchar (50),
@endereco varchar (90),
@descricao varchar (80),
@proprietario varchar (50),
@ID int
as
insert into Cadastro  values (@RECEBIDO,@CODIGO,@ENDERECO,@DESCRICAO,@PROPRIETARIO,@ID)

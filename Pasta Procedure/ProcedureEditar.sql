/****** Object:  StoredProcedure [dbo].[Editaradastrado]    Script Date: 06/07/2020 22:36:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------EDITAR

ALTER proc [dbo].[Editaradastrado]
@recebido varchar (50),
@codigo varchar (50),
@endereco varchar (90),
@descricao varchar (80),
@proprietario varchar(50),
@id int
as
update cadastro set recebido=@recebido, codigo=@codigo, endereco=@endereco, descricao=@descricao, proprietario=@proprietario where Id=@id

/****** Object:  StoredProcedure [dbo].[DeletarCadastro]    Script Date: 06/07/2020 22:35:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------ELIMINAR
ALTER proc [dbo].[DeletarCadastro]
@id int
as
delete from cadastro where ID=@id

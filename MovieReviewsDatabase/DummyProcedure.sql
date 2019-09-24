CREATE PROCEDURE [dbo].[DummyProcedure](@param1 int, @param2 int OUTPUT)
AS 
BEGIN 
	SELECT 'This is another change for testing deployment procedure';
END

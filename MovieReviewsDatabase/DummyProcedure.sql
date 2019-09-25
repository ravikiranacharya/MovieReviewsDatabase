CREATE PROCEDURE [dbo].[DummyProcedure](@param1 int, @param2 int OUTPUT)
AS 
BEGIN 
	SELECT 'If this is shown, Octopus Deploy setup is working';
END

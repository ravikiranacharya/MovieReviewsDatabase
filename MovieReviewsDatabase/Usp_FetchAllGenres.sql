CREATE PROCEDURE [dbo].[Usp_FetchAllGenres](@param1 int, @param2 int OUTPUT)
AS 
BEGIN
	SELECT * FROM Genres
	ORDER BY id DESC
END

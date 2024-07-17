-- Primera consulta
SELECT TOP 200 DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;


-- Segunda consulta
SELECT TOP 200 Posts.Title, Users.DisplayName
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL
AND Posts.Title IS NOT NULL;


-- Tercera consulta
SELECT TOP 200 Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL
GROUP BY Users.DisplayName
ORDER BY AverageScore DESC;


-- Cuarta consulta
SELECT TOP 200 DisplayName
FROM Users
WHERE Id IN (
    SELECT UserId
    FROM Comments
    GROUP BY UserId
    HAVING COUNT(*) > 100
)
ORDER BY DisplayName;


-- Quinta Consulta
-- Realizar la actualización
SELECT TOP 200 Location
from Users
UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = '';

-- Mostrar cuántas filas se actualizaron
PRINT 'La actualización se realizó correctamente.';


-- Sexta Consulta
-- Eliminar los comentarios de usuarios con menos de 100 de reputación
DELETE FROM Comments
WHERE UserId IN (
    SELECT Id
    FROM Users
    WHERE Reputation < 100
);

-- Mostrar cuántos comentarios fueron eliminados
SELECT @@ROWCOUNT AS ComentariosEliminados;

-- Aparte
-- Mostrar tabla de comentarios para ver si se eliminaron todos los menores a 100
SELECT TOP 200 Comments.text,Users.DisplayName, Users.Reputation
FROM Comments
JOIN Users ON Comments.UserId = Users.Id
ORDER BY reputation ASC


-- Septima Consulta
SELECT TOP 200 Users.DisplayName, 
       ISNULL(Comments.NumCom, 0) AS NumCom, 
       ISNULL(Posts.NumPosts, 0) AS NumPosts, 
       ISNULL(Badges.NumBadges, 0) AS NumBadges
FROM Users
LEFT JOIN (
    SELECT UserId, COUNT(*) AS NumCom
    FROM Comments
    GROUP BY UserId
) AS Comments ON Users.Id = Comments.UserId
LEFT JOIN (
    SELECT OwnerUserId, COUNT(*) AS NumPosts
    FROM Posts
    GROUP BY OwnerUserId
) AS Posts ON Users.Id = Posts.OwnerUserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS NumBadges
    FROM Badges
    GROUP BY UserId
) AS Badges ON Users.Id = Badges.UserId

ORDER BY Users.DisplayName;


-- Octava Consulta
SELECT TOP 10 Posts.Title, Posts.Score
FROM Posts
ORDER BY Posts.Score DESC;


-- Novena Consulta
SELECT TOP 5 Comments.Text, Comments.CreationDate
FROM Comments
ORDER BY Comments.CreationDate DESC;



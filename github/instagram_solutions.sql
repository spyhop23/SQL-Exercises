USE instagram;

-- 1. Finding 5 oldest users
SELECT * FROM users
ORDER BY created_at LIMIT 5;

-- 2. Most Popular Registration Date
SELECT DAYNAME(created_at) AS day, count(*) FROM users
GROUP BY day
ORDER BY count(*) DESC;

-- 3. Identify Inactive Users (users with no photos)
SELECT username from users
LEFT JOIN photos
	ON photos.user_id = users.id
WHERE photos.id IS NULL;

-- 4. Identify most popular photo (and User who posted it)
SELECT photos.id AS photo_id, img_url, username, count(*) AS likes FROM photos
JOIN likes ON likes.photo_id = photos.id
JOIN users ON users.id = photos.user_id
GROUP BY likes.photo_id
ORDER BY count(*) DESC LIMIT 1;

-- 5. Calculate avg number of photos per user
SELECT (SELECT count(*) FROM photos) / (SELECT count(*) FROM users) AS avg;

-- 6. Five Most popular hashtags
SELECT tag_name, count(*) AS total FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY total DESC LIMIT 5;

-- 7. Finding Bots - users who have liked every single photo
SELECT user_id, username, count(*) AS num_likes FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY user_id 
HAVING count(*) = (SELECT count(*) FROM photos)
ORDER BY user_id;

SELECT COUNT(DISTINCT utm_campaign) AS 'Number of Distinct Campaigns'
FROM page_visits;

SELECT DISTINCT COUNT(utm_source) AS 'Number of Distinct Source'
FROM page_visits;

SELECT utm_campaign AS 'Campaign', 
	utm_source AS 'Source‘
FROM page_visits
GROUP BY utm_campaign;

SELECT DISTINCT page_name AS 'Page'
FROM page_visits;

WITH first_touch AS
(SELECT user_id,
  MIN(timestamp) AS first_touch_at
FROM page_visits
GROUP BY user_id)
SELECT pv.utm_campaign AS 'Campaign',
COUNT(ft.user_id) AS 'Number of First Touch'
FROM first_touch AS ft
JOIN page_visits AS pv
ON ft.user_id=pv.user_id
AND ft.first_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;

WITH last_touch AS
(SELECT user_id,
  MAX(timestamp) AS last_touch_at
FROM page_visits
GROUP BY user_id)
SELECT pv.utm_campaign AS 'Campaign',
COUNT(lt.user_id) AS 'Number of Last Touch'
FROM last_touch AS lt
JOIN page_visits AS pv
ON lt.user_id=pv.user_id
AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;
SELECT COUNT(user_id)
FROM page_visits
WHERE page_name='4 - purchase';

WITH last_touch AS
(SELECT user_id,
  MAX(timestamp) AS last_touch_at
FROM page_visits
GROUP BY user_id)
SELECT pv.utm_campaign AS 'Campaign',
COUNT(lt.user_id) AS 'Number of Last Touch'
FROM last_touch AS lt
JOIN page_visits AS pv
ON lt.user_id=pv.user_id
AND lt.last_touch_at = pv.timestamp
WHERE pv.page_name='4 - purchase'
GROUP BY 1
ORDER BY 2 DESC;


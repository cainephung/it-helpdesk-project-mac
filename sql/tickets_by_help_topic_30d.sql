-- Ticket count by Help Topic for the last 30 days
SELECT
  ht.topic AS help_topic,
  COUNT(*) AS tickets_last_30d
FROM ost_ticket t
JOIN ost_help_topic ht ON ht.topic_id = t.topic_id
WHERE t.created >= (NOW() - INTERVAL 30 DAY)
GROUP BY ht.topic
ORDER BY tickets_last_30d DESC;

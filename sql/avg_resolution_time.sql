-- Average resolution time (in minutes) for closed tickets
-- Assumes default table names in osTicket 1.18.x
SELECT
  ROUND(AVG(TIMESTAMPDIFF(MINUTE, t.created, t.closed)), 1) AS avg_resolution_minutes
FROM ost_ticket t
JOIN ost_ticket_status s ON s.id = t.status_id
WHERE s.state = 'closed' AND t.closed IS NOT NULL;

# Event Sourcing in Rails Example Application

Inspired from [this presentation](https://skillsmatter.com/skillscasts/11903-an-introduction-to-event-sourcing).

## Testing with CURL

These tests assume the docker container is running (via docker-compose) and the database has been created, migrated and seeded!

To schedule a new meeting try the following command

```
curl -d '{"meeting": {"time": "2019-10-30 04:00", "organizer_id":1, "invitee_ids": [1,2]}}' -H "Content-Type: application/json" -X POST http://localhost:3000/meetings/create
```



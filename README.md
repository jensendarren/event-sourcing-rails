# Event Sourcing in Rails Example Application

Inspired from [this presentation](https://skillsmatter.com/skillscasts/11903-an-introduction-to-event-sourcing).

## Testing with CURL

These tests assume the docker container is running (via docker-compose) and the database has been created, migrated and seeded!

To schedule a new meeting try the following command

```
curl -d '{"meeting": {"time": "2019-10-30 04:00", "organizer_id":1, "invitee_ids": [1,2]}}' -H "Content-Type: application/json" -X POST http://localhost:3000/meetings/create
```

## TODO

* Add whisper gem and subscribe to events to actually save the meeting + send emails (from a separate subscriber class)
* Make a request to create / accept a meeting
* Test replay / audit trail / debugging

## Event Sourcing Videos

* https://www.youtube.com/watch?v=YNfAwvgUWjo
* https://www.youtube.com/watch?v=cdwX1ZU623E
* https://www.youtube.com/watch?v=aweV9FLTZkU

## Event Sourcing Blogs / Examples

* https://gist.github.com/mottalrd/52a99a0a67275013df5a66281a4a1b11
* https://assist-software.net/blog/introduction-event-sourcing-ruby-rails
* https://blog.arkency.com/a-scary-side-of-activerecords-find/

## Example use cases

* Audit Trail
* Debugging
* Historic State
* Varient Schemas
* Distribution Suppoert
* In Memory Processing
* Alternative Histories
expect = require('chai').expect
fs = require('fs')
converter = require('../src/object_converter')

describe 'converting a single object', ->
  loadFixture = (name) ->
    JSON.parse(fs.readFileSync("./test/fixtures/notifications/#{name}.json"))

  describe 'a commentCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('commentCard')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.commentCard",
          "displayName": "commented on card"
        },
        "published": "2014-12-24T04:42:03.678Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.bilbobaggins",
          "displayName": "Bilbo Baggins",
          "url": "http://trello.com/bilbobaggins",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/b44ca6979b87431323664ee46d75c7/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.5496646974598104ca4fc6"
          "url": "http://trello.com/c/GJGTBRY0",
          "displayName": "The name of the card"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.52b2536953920ef20020bf",
          "displayName": "My Board",
          "url": "http://trello.com/b/FO98bRzg"
        },
        "result": {
          "text": "This is the comment test that was added."
        }
     })

    it 'builds doesnt build an image if there is no avatar hash', ->
      commentCard = loadFixture('no_avatar')
      activity = converter(commentCard)
      expect(activity.actor).to.deep.eq({
        "objectType": "person",
        "id": "trello.bilbobaggins",
        "displayName": "Bilbo Baggins",
        "url": "http://trello.com/bilbobaggins",
      })      

  describe 'a removedFromCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('removedFromCard')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.removedFromCard",
          "displayName": "removed from card"
        },
        "published": "2014-12-29T05:14:55.573Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.samgamgee",
          "displayName": "Samwise Gamgee",
          "url": "http://trello.com/samgamgee",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/04efae26fd242a912663e3630551b6/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "[2] Import all non-listing data from upper hutt onto production"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "PropertyNZ Sprint",
          "url": "http://trello.com/b/Az1wabpW"
        }
     })

  describe 'an addedToCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('addedToCard')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.addedToCard",
          "displayName": "added to card"
        },
        "published": "2014-12-29T05:14:55.573Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.samgamgee",
          "displayName": "Samwise Gamgee",
          "url": "http://trello.com/samgamgee",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/04efae26fd242a912663e3630551b6/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "[2] Import all non-listing data from upper hutt onto production"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "PropertyNZ Sprint",
          "url": "http://trello.com/b/Az1wabpW"
        }
     })

  describe 'a changedCard event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('changedCard')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.changeCard",
          "displayName": "changed card"
        },
        "published": "2014-12-19T23:33:56.825Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.samgamgee",
          "displayName": "Samwise Gamgee",
          "url": "http://trello.com/samgamgee",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/04efae26fd242a912663e3630551b6/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "[2] Import all non-listing data from upper hutt onto production"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "PropertyNZ Sprint",
          "url": "http://trello.com/b/Az1wabpW"
        }
     })

  describe 'an added to board event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('addedToBoard')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.addedToBoard",
          "displayName": "added to board"
        },
        "published": "2014-12-19T04:33:13.547Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.bilbobaggins",
          "displayName": "Bilbo Baggins",
          "url": "http://trello.com/bilbobaggins",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/b44ca6979b87431323664ee46d75c7/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.board",
          "id": "trello.54936b27cba4128aefc0ebe1",
          "displayName": "Some board",
          "url": "http://trello.com/b/rfwTnCsC"
        }
     })

  describe 'a mentioned on card event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('mentionedOnCard')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.mentionedOnCard",
          "displayName": "mentioned on card"
        },
        "published": "2014-12-18T04:24:30.499Z",
        "language": "en",
        "actor": {
          "objectType": "person",
          "id": "trello.bilbobaggins",
          "displayName": "Bilbo Baggins",
          "url": "http://trello.com/bilbobaggins",
          "image": {
            "url": "https://trello-avatars.s3.amazonaws.com/b44ca6979b87431323664ee46d75c7/170.png",
            "mediaType": "image/jpeg",
            "width": 170,
            "height": 170
          }
        },
        "object" : {
          "objectType": "trello.card",
          "id": "trello.546a650bc8837b1d5588a188"
          "url": "http://trello.com/c/BcoRhZxG",
          "displayName": "card name"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.53fc171865067982a4de41b2",
          "displayName": "Some board",
          "url": "http://trello.com/b/Az1wabpW"
        }        
     })

  describe 'a card due soon event', ->
    it 'builds a valid activity', ->
      commentCard = loadFixture('cardDueSoon')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "verb": {
          "id": "trello.cardDueSoon",
          "displayName": "card due soon"
        },
        "published": "2014-12-17T23:11:05.635Z",
        "language": "en",
        "object" : {
          "objectType": "trello.card",
          "id": "trello.5449bb9636b9b437ea26d44a"
          "url": "http://trello.com/c/7Ewl2oZU",
          "displayName": "Project Lead Training workshop [$240]",
          "endTime": "2014-12-18T23:00:00.000Z"
        },
        "target" : {
          "objectType": "trello.board",
          "id": "trello.5449ac765ca834b03d93fe39",
          "displayName": "Enspiral Services Buckets",
        }        
     })

  describe 'an unknown notification type', ->
    it 'emits an error object with the full original notification', ->
      commentCard = loadFixture('unknownNotification')
      activity = converter(commentCard)
      expect(activity).to.deep.eq({
        "error": "unknown_notification_type",
        "originalObject": {
          "id": "54a0e34f9b66e96be59d5953",
          "unread": true,
          "type": "someFakeNotificationType",
          "date": "2014-12-29T05:14:55.573Z",
          "data": {
            "card": {
              "shortLink": "BcoRhZxG",
              "idShort": 110,
              "name": "[2] Import all non-listing data from upper hutt onto production",
              "id": "546a650bc8837b1d5588a188"
            },
          },
          "idMemberCreator": "5168e66143fa33e94f0018a6"
        }      
     })

prefix = 'trello'
url = 'http://trello.com'
avatarSize = 170

actions = {
  commentCard: 
    displayName: 'commented on card'
    object: 'card'
  removedFromCard: 
    displayName: 'removed from card'
    object: 'card'
  addedToCard: 
    displayName: 'added to card'
    object: 'card'
  changeCard: 
    displayName: 'changed card'
    object: 'card'
  addedToBoard:
    displayName: 'added to board'
    object: 'board'
}

objectTranslators = {
  board: (board) ->
    objectType: "#{prefix}.board"
    id: "#{prefix}.#{board.id}"
    displayName: board.name
    url: "#{url}/b/#{board.shortLink}"

  card: (card) ->
    objectType: "#{prefix}.card"
    id: "#{prefix}.#{card.id}"
    url: "#{url}/c/#{card.shortLink}"
    displayName: card.name
}

personObject = (person) ->
  output =
    objectType: "person"
    id: "#{prefix}.#{person.username}"
    displayName: person.fullName
    url: "#{url}/#{person.username}"
  if person.avatarHash
    output.image = imageObject(person.avatarHash)
  output

imageObject = (avatarHash) ->
  url: "https://trello-avatars.s3.amazonaws.com/#{avatarHash}/#{avatarSize}.png"
  mediaType: "image/jpeg"
  width: avatarSize
  height: avatarSize

verbObject = (notificationType) ->
  id: "trello.#{notificationType}"
  displayName: actions[notificationType].displayName

resultForNotification = (notification) ->
  if notification.type == 'commentCard'
    {text: notification.data.text}

dataObject = (objectType, notification) ->
  objectData = notification.data[objectType]
  objectMethod = objectTranslators[objectType]

  objectMethod(objectData)

actionObject = (notification) ->
  objectType = actions[notification.type].object
  objectData = notification.data[objectType]
  objectMethod = objectTranslators[objectType]

  objectMethod(objectData)

actionTarget = (notification) ->
  objectType = actions[notification.type].object
  if objectType == 'card'
    targetType = 'board'
    dataObject 'board', notification
  else
    null

module.exports =
  notificationToActivity: (notification) ->
    result = resultForNotification(notification)
    target = actionTarget(notification)

    output =
      verb:      verbObject(notification.type)
      published: notification.date
      language:  "en"
      actor:     personObject(notification.memberCreator)
      object:    actionObject(notification)

    output.target = target if target
    output.result = result if result
    output
App.buckets ||= {}

App.buckets['show'] = ->
  ZeroClipboard.config(moviePath: '/flash/ZeroClipboard.swf')

  window.client = new ZeroClipboard $('#copy-button')
  htmlBridge = '#global-zeroclipboard-html-bridge'

  tipsyConfig = title: 'Copy to Clipboard', copiedHint: 'Copied!'

  $(htmlBridge).tipsy(gravity: $.fn.tipsy.autoNS)
  $(htmlBridge).attr('title', tipsyConfig.title)

  client.on('complete', (client, args) -> $('#putsbox-token-input').focus().blur())

  $(htmlBridge).prop('title', tipsyConfig.copiedHint).tipsy('show')
  $(htmlBridge).attr('original-title', tipsyConfig.title)

  startPoller()

  do ->
    favicon = new Favico(bgColor: '#6C92C8', animation: 'none')
    favicon.badge($('#putsbox-token-input').data('bucket-emails-count'))

    $('body').on('new-email', (e, data) -> favicon.badge data.emailsCount)


startPoller = ->
  bucket = $('#putsbox-token-input').data('bucket-token')

  pusher = new Pusher($('body').data('pusher-key'), { cluster: $('body').data('pusher-cluster'), encrypted: true })

  channel = pusher.subscribe("channel_emails_#{bucket}")

  channel.bind('update_count', (data) -> $('body').trigger('new-email', email: data.email, emailsCount: data.emails_count))

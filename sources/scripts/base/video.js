
define([], function()
{
  var Video = function (URL)
  {
  	this.isReady = false
    this.URL = URL

  	this.DOM = document.createElement('video')
  	this.DOM.preload = "auto"
  	this.DOM.loop = true
  	this.DOM.muted = true
  	this.DOM.src = this.URL

  	var self = this
  	this.DOM.addEventListener("canplaythrough", function () {
			if ( self.isReady == false )
			{
				// Video Element
				self.DOM.play()

        self.shuffle()

				self.isReady = true
			}
  	}
  		, true
  	)

    this.shuffle = function ()
    {
      this.DOM.currentTime = Math.random() * this.DOM.duration
    }
  }

  return Video
})
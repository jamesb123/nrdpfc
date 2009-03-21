// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

  ElementFader=Class.create();
  ElementFader.prototype={
    initialize:function(field, element, show_condition, options)
    {
      this.options=$H({ 
        effect:"blind"
      }).merge(options);
      
      this.element=$(element);
      this.field=$(field);
      this.show_condition=show_condition;
      this.currentEffect=null;

      this.wasShown=this.shouldShow();
      this.element.style.display= this.shouldShow() ? "" : "none";
      
      // set our event listener
      this.field.setstate=this.setState.bindAsEventListener(this);

      if (this.field.type=="radio")
      {
        thiz=this;
        ['focus', 'blur', 'click'].each( function (ev) {
          $A(thiz.field.form[thiz.field.name]).each( function(peer_field) {
            Event.observe(peer_field, ev, thiz.field.setstate);
          });
        });
      }
      else
        Event.observe(this.field, "change", this.setState.bindAsEventListener(this));
    },
    shouldShow:function()
    {
      value=$F(this.field);
      return eval("value " + this.show_condition);
    },
    setState: function (){
      show=this.shouldShow();
      if (this.wasShown == show) return; // No State change?  Do nothing
      this.wasShown = show;
      
      if (this.currentEffect)
      {
        this.currentEffect.cancel()
        this.element.style.height="";
      }

      if (this.options.effect=="none")
        this.element.style.display= show ? "" : "none";
      else
      {
        if (show)
          this.currentEffect=Effect.BlindDown(this.element);
        else
        {
          this.currentEffect=Effect.BlindUp(this.element);
        }
      }
    }
  }
// These are included to change the Effects.js library to work with IE
Effect.BlindUp = function(element) {
  element = $(element);
  element.makeClipping();
  return new Effect.Scale(element, 5, 
    Object.extend({ scaleContent: false, 
      scaleX: false, 
      restoreAfterFinish: true,
      afterFinishInternal: function(effect) {
        effect.element.hide();
        effect.element.undoClipping();
      } 
    }, arguments[1] || {})
  );
}

Effect.BlindDown = function(element) {
  element = $(element);
  var elementDimensions = element.getDimensions();
  return new Effect.Scale(element, 100, 
    Object.extend({ scaleContent: false, 
      scaleX: false,
      scaleFrom: 5,
      scaleMode: {originalHeight: elementDimensions.height, originalWidth: elementDimensions.width},
      restoreAfterFinish: true,
      afterSetup: function(effect) {
        effect.element.makeClipping();
        effect.element.setStyle({height: '0px'});
        effect.element.show(); 
      },  
      afterFinishInternal: function(effect) {
        effect.element.undoClipping();
      }
    }, arguments[1] || {})
  );
}

/**
 * @author Jim
 */
var BrowserDetect = {
	init: function () {
		this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
		this.version = this.searchVersion(navigator.userAgent)
			|| this.searchVersion(navigator.appVersion)
			|| "an unknown version";
		this.OS = this.searchString(this.dataOS) || "an unknown OS";
	},
	searchString: function (data) {
		for (var i=0;i<data.length;i++)	{
			var dataString = data[i].string;
			var dataProp = data[i].prop;
			this.versionSearchString = data[i].versionSearch || data[i].identity;
			if (dataString) {
				if (dataString.indexOf(data[i].subString) != -1)
					return data[i].identity;
			}
			else if (dataProp)
				return data[i].identity;
		}
	},
	searchVersion: function (dataString) {
		var index = dataString.indexOf(this.versionSearchString);
		if (index == -1) return;
		return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
	},
	dataBrowser: [
		{
			string: navigator.userAgent,
			subString: "Chrome",
			identity: "Chrome"
		},
		{ 	string: navigator.userAgent,
			subString: "OmniWeb",
			versionSearch: "OmniWeb/",
			identity: "OmniWeb"
		},
		{
			string: navigator.vendor,
			subString: "Apple",
			identity: "Safari",
			versionSearch: "Version"
		},
		{
			prop: window.opera,
			identity: "Opera"
		},
		{
			string: navigator.vendor,
			subString: "iCab",
			identity: "iCab"
		},
		{
			string: navigator.vendor,
			subString: "KDE",
			identity: "Konqueror"
		},
		{
			string: navigator.userAgent,
			subString: "Firefox",
			identity: "Firefox"
		},
		{
			string: navigator.vendor,
			subString: "Camino",
			identity: "Camino"
		},
		{		// for newer Netscapes (6+)
			string: navigator.userAgent,
			subString: "Netscape",
			identity: "Netscape"
		},
		{
			string: navigator.userAgent,
			subString: "MSIE",
			identity: "Explorer",
			versionSearch: "MSIE"
		},
		{
			string: navigator.userAgent,
			subString: "Gecko",
			identity: "Mozilla",
			versionSearch: "rv"
		},
		{ 		// for older Netscapes (4-)
			string: navigator.userAgent,
			subString: "Mozilla",
			identity: "Netscape",
			versionSearch: "Mozilla"
		}
	],
	dataOS : [
		{
			string: navigator.platform,
			subString: "Win",
			identity: "Windows"
		},
		{
			string: navigator.platform,
			subString: "Mac",
			identity: "Mac"
		},
		{
			   string: navigator.userAgent,
			   subString: "iPhone",
			   identity: "iPhone/iPod"
	    },
		{
			string: navigator.platform,
			subString: "Linux",
			identity: "Linux"
		}
	]

};
BrowserDetect.init();


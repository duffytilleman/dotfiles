// Configs
slate.cfga({
  "defaultToCurrentScreen": true,
  "secondsBetweenRepeat": 0.1,
  "checkDefaultsOnLoad": true,
  "focusCheckWidthMax": 3000
});

var moveOp = function(x, y, w, h) {
  return slate.operation("move", {
    "x": x,
    "y": y,
    "width": w,
    "height": h
  });
};

var resizeOp = function(percentage, anchor) {
  var percentageWidth  = percentage,
      percentageHeight = percentage,
      realAnchor = anchor;
  switch(anchor) {
    case "top-half":
      percentageWidth = "0%";
      realAnchor = "top-left";
      break;
    case "bottom-half":
      percentageWidth = "0%";
      realAnchor = "bottom-left";
      break;
    case "left-half":
      percentageHeight = "0%";
      realAnchor = "top-left";
      break;
    case "right-half":
      percentageHeight = "0%";
      realAnchor = "top-right";
      break;
    case "centered":
      realAnchor = "top-left";
      break;
  }
  return slate.operation("resize", {
    "width": percentageWidth,
    "height": percentageHeight,
    "anchor": realAnchor
  });
};

var getAnchor = function(screenRect, winRect) {
  var anchor = "top-left";
  var anchorPercentage = 0.02;
  var menuBarHeight = 22;
  var leftAnchored = Math.abs(winRect.x - screenRect.x) <= anchorPercentage * screenRect.width;
  var rightAnchored = Math.abs((winRect.x + winRect.width) - (screenRect.x + screenRect.width)) <= anchorPercentage * screenRect.width;
  var topAnchored = Math.abs(winRect.y - screenRect.y - menuBarHeight) <= anchorPercentage * screenRect.height;
  var bottomAnchored = Math.abs((winRect.y + winRect.height) - (screenRect.y + screenRect.height)) <= anchorPercentage * screenRect.height;

  if(topAnchored && leftAnchored)          { anchor = "top-left";     }
  else if(topAnchored && rightAnchored)    { anchor = "top-right";    }
  else if(bottomAnchored && leftAnchored)  { anchor = "bottom-left";  }
  else if(bottomAnchored && rightAnchored) { anchor = "bottom-right"; }

  return anchor;
}

var maximized     = moveOp("screenOriginX", "screenOriginY", "screenSizeX", "screenSizeY");

var topLeft       = moveOp("screenOriginX", "screenOriginY", "screenSizeX/2", "screenSizeY/2");
var topHalf       = moveOp("screenOriginX", "screenOriginY", "screenSizeX", "screenSizeY/2");
var topRight      = moveOp("screenOriginX+screenSizeX/2", "screenOriginY", "screenSizeX/2", "screenSizeY/2");

var leftTwoThird  = moveOp("screenOriginX", "screenOriginY", "screenSizeX * 2/3", "screenSizeY");
var leftThird     = moveOp("screenOriginX", "screenOriginY", "screenSizeX * 1/3", "screenSizeY");

var rightHalf     = moveOp("screenOriginX+screenSizeX/2", "screenOriginY", "screenSizeX/2", "screenSizeY");
var leftHalf      = moveOp("screenOriginX", "screenOriginY", "screenSizeX/2", "screenSizeY");
var centered      = moveOp("screenOriginX+screenSizeX*0.1", "screenOriginY+screenSizeY*0.1", "screenSizeX*0.8", "screenSizeY*0.8");
var rightHalf     = moveOp("screenOriginX+screenSizeX/2", "screenOriginY", "screenSizeX/2", "screenSizeY");
var rightThird    = moveOp("screenOriginX+screenSizeX * 2/3", "screenOriginY", "screenSizeX * 1/3", "screenSizeY");
var rightTwoThird = moveOp("screenOriginX+screenSizeX * 1/3", "screenOriginY", "screenSizeX * 2/3", "screenSizeY");

var bottomLeft    = moveOp("screenOriginX", "screenOriginY+screenSizeY/2", "screenSizeX/2", "screenSizeY/2");
var bottomHalf    = moveOp("screenOriginX", "screenOriginY+screenSizeY/2", "screenSizeX", "screenSizeY/2");
var bottomRight   = moveOp("screenOriginX+screenSizeX/2", "screenOriginY+screenSizeY/2", "screenSizeX/2", "screenSizeY/2");

var percentage = "10%";

// Batch bind everything. Less typing.
slate.bnda({
  "space:cmd;ctrl": maximized,

  "u:cmd;ctrl": topLeft,
  "i:cmd;ctrl": topHalf,
  "o:cmd;ctrl": topRight,

  "g:cmd;ctrl": leftTwoThird,
  "h:cmd;ctrl": leftThird,

  "j:cmd;ctrl": leftHalf,
  "k:cmd;ctrl": centered,
  "l:cmd;ctrl": rightHalf,

  ";:cmd;ctrl": rightThird,
  "':cmd;ctrl": rightTwoThird,

  "m:cmd;ctrl": bottomLeft,
  ",:cmd;ctrl": bottomHalf,
  ".:cmd;ctrl": bottomRight,


  "u:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "top-left"));
  },
  "i:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "top-half"));
  },
  "o:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "top-right"));
  },

  "l:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "left-half"));
  },
  "k:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "centered"));
  },
  "j:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "right-half"));
  },

  "m:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "bottom-left"));
  },
  ",:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "bottom-half"));
  },
  ".:cmd;ctrl;alt;shift": function(win) {
    win.doOperation(resizeOp("-"+percentage, "bottom-right"));
  },


  "u:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "bottom-right"));
  },
  "i:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "bottom-half"));
  },
  "o:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "bottom-left"));
  },

  "j:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "right-half"));
  },
  "k:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "centered"));
  },
  "l:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "left-half"));
  },

  "m:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "top-right"));
  },
  ",:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "top-half"));
  },
  ".:cmd;ctrl;alt": function(win) {
    win.doOperation(resizeOp("+"+percentage, "top-left"));
  },


  // "-:cmd;ctrl;alt": function(win) {
  //   var anchor = getAnchor(slate.screen().rect(), win.rect());
  //   win.doOperation(resizeOp("-10%", anchor));
  // },
  // "=:cmd;ctrl;alt": function(win) {
  //   var anchor = getAnchor(slate.screen().rect(), win.rect());
  //   win.doOperation(resizeOp("+10%", anchor));
  // },
});




// Test Cases
slate.src(".slate.test", true);
slate.src(".slate.test.js", true);

// Log that we're done configuring
slate.log("[SLATE] -------------- Finished Loading Config --------------");

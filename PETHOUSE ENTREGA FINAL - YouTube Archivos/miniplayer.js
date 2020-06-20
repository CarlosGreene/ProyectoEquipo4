(function(g){var window=this;var L5=function(a,b){var c="ytp-miniplayer-button-bottom-right";var d=g.W?{F:"div",Y:["ytp-icon","ytp-icon-expand-watch-page"]}:{F:"svg",P:{height:"18px",version:"1.1",viewBox:"0 0 22 18",width:"22px"},L:[{F:"g",P:{fill:"none","fill-rule":"evenodd",stroke:"none","stroke-width":"1"},L:[{F:"g",P:{transform:"translate(-1.000000, -3.000000)"},L:[{F:"polygon",P:{points:"0 0 24 0 24 24 0 24"}},{F:"path",P:{d:"M19,7 L5,7 L5,17 L19,17 L19,7 Z M23,19 L23,4.98 C23,3.88 22.1,3 21,3 L3,3 C1.9,3 1,3.88 1,4.98 L1,19 C1,20.1 1.9,21 3,21 L21,21 C22.1,21 23,20.1 23,19 Z M21,19.02 L3,19.02 L3,4.97 L21,4.97 L21,19.02 Z",
fill:"#fff","fill-rule":"nonzero"}}]}]}]};var e="Abrir p\u00e1gina del video";a.O().ia("kevlar_miniplayer_expand_top")&&(c="ytp-miniplayer-button-top-left",d=g.W?{F:"div",Y:["ytp-icon","ytp-icon-expand-miniplayer"]}:{F:"svg",P:{height:"24px",version:"1.1",viewBox:"0 0 24 24",width:"24px"},L:[{F:"g",P:{fill:"none","fill-rule":"evenodd",stroke:"none","stroke-width":"1"},L:[{F:"g",P:{transform:"translate(12.000000, 12.000000) scale(-1, 1) translate(-12.000000, -12.000000) "},L:[{F:"path",P:{d:"M19,19 L5,19 L5,5 L12,5 L12,3 L5,3 C3.89,3 3,3.9 3,5 L3,19 C3,20.1 3.89,21 5,21 L19,21 C20.1,21 21,20.1 21,19 L21,12 L19,12 L19,19 Z M14,3 L14,5 L17.59,5 L7.76,14.83 L9.17,16.24 L19,6.41 L19,10 L21,10 L21,3 L14,3 Z",
fill:"#fff","fill-rule":"nonzero"}}]}]}]},e="Expandir");g.Q.call(this,{F:"button",Y:["ytp-miniplayer-expand-watch-page-button","ytp-button",c],P:{title:"{{title}}","data-tooltip-target-id":"ytp-miniplayer-expand-watch-page-button"},L:[d]});this.K=a;this.na("click",this.onClick,this);this.oa("title",g.XN(a,e,"i"));g.Ke(this,g.AN(b.jb(),this.element))},M5=function(a){g.Q.call(this,{F:"div",
I:"ytp-miniplayer-ui"});this.player=a;this.J=!1;this.H=this.A=this.u=void 0;this.M(a,"minimized",this.aJ);this.M(a,"onStateChange",this.BO)},N5=function(a){g.OL.call(this,a);
this.o=new M5(this.player);this.o.hide();g.CL(this.player,this.o.element,4);a.app.H.o&&(this.load(),g.J(a.getRootNode(),"ytp-player-minimized",!0))};
g.r(L5,g.Q);L5.prototype.onClick=function(){this.K.ra("onExpandMiniplayer")};g.r(M5,g.Q);g.k=M5.prototype;
g.k.show=function(){this.u=new g.wn(this.ZI,null,this);this.u.start();if(!this.J){this.D=new g.HR(this.player,this);g.A(this,this.D);g.CL(this.player,this.D.element,4);this.D.B=.6;this.V=new g.FQ(this.player);g.A(this,this.V);this.B=new g.Q({F:"div",I:"ytp-miniplayer-scrim"});g.A(this,this.B);this.B.da(this.element);this.M(this.B.element,"click",this.tB);var a=new g.Q({F:"button",Y:["ytp-miniplayer-close-button","ytp-button"],P:{"aria-label":"Cerrar"},L:[g.ZM()]});g.A(this,a);a.da(this.B.element);
this.M(a.element,"click",this.Zz);a=new L5(this.player,this);g.A(this,a);a.da(this.B.element);this.C=new g.Q({F:"div",I:"ytp-miniplayer-controls"});g.A(this,this.C);this.C.da(this.B.element);this.M(this.C.element,"click",this.tB);var b=new g.Q({F:"div",I:"ytp-miniplayer-button-container"});g.A(this,b);b.da(this.C.element);a=new g.Q({F:"div",I:"ytp-miniplayer-play-button-container"});g.A(this,a);a.da(this.C.element);var c=new g.Q({F:"div",I:"ytp-miniplayer-button-container"});g.A(this,c);c.da(this.C.element);
this.T=new g.rO(this.player,this,!1);g.A(this,this.T);this.T.da(b.element);b=new g.nO(this.player,this);g.A(this,b);b.da(a.element);this.N=new g.rO(this.player,this,!0);g.A(this,this.N);this.N.da(c.element);this.H=new g.XP(this.player,this);g.A(this,this.H);this.H.da(this.B.element);this.A=new g.DO(this.player,this);g.A(this,this.A);g.CL(this.player,this.A.element,4);this.G=new g.Q({F:"div",I:"ytp-miniplayer-buttons"});g.A(this,this.G);g.CL(this.player,this.G.element,4);a=new g.Q({F:"button",Y:["ytp-miniplayer-close-button",
"ytp-button"],P:{"aria-label":"Cerrar"},L:[g.ZM()]});g.A(this,a);a.da(this.G.element);this.M(a.element,"click",this.Zz);a=new g.Q({F:"button",Y:["ytp-miniplayer-replay-button","ytp-button"],P:{"aria-label":"Cerrar"},L:[g.mN()]});g.A(this,a);a.da(this.G.element);this.M(a.element,"click",this.zM);this.M(this.player,"presentingplayerstatechange",this.bJ);this.M(this.player,"appresize",this.au);this.M(this.player,"fullscreentoggled",this.au);this.au();this.J=!0}0!=this.player.getPlayerState()&&g.Q.prototype.show.call(this);
this.A.show();this.player.unloadModule("annotations_module")};
g.k.hide=function(){this.u&&(this.u.dispose(),this.u=void 0);g.Q.prototype.hide.call(this);this.player.app.H.o||(this.J&&this.A.hide(),this.player.loadModule("annotations_module"))};
g.k.Z=function(){this.u&&(this.u.dispose(),this.u=void 0);g.Q.prototype.Z.call(this)};
g.k.Zz=function(){this.player.stopVideo();this.player.ra("onCloseMiniplayer")};
g.k.zM=function(){this.player.playVideo()};
g.k.tB=function(a){if(a.target==this.B.element||a.target==this.C.element)g.O(this.player.O().experiments,"kevlar_miniplayer_play_pause_on_scrim")?g.MC(g.iL(this.player))?this.player.pauseVideo():this.player.playVideo():this.player.ra("onExpandMiniplayer")};
g.k.aJ=function(){g.J(this.player.getRootNode(),"ytp-player-minimized",this.player.app.H.o)};
g.k.ZI=function(){this.A.Ub();this.H.Ub();this.u&&this.u.start()};
g.k.bJ=function(a){g.U(a.state,32)&&this.D.hide()};
g.k.au=function(){g.XO(this.A,0,g.jL(this.player).getPlayerSize().width,!1);this.A.Av()};
g.k.BO=function(a){this.player.app.H.o&&(0==a?this.hide():this.show())};
g.k.jb=function(){return this.D};
g.k.sc=function(){return!1};
g.k.Ud=function(){return!1};
g.k.cj=function(){return!1};
g.k.fv=function(){};
g.k.Bi=function(){};
g.k.Kl=function(){};
g.k.wm=function(){return null};
g.k.Zt=function(){return new g.uh(0,0,0,0)};
g.k.handleGlobalKeyDown=function(){return!1};
g.k.handleGlobalKeyUp=function(){return!1};
g.k.Mk=function(a,b,c,d,e){var f=0,h=d=0,l=g.Qh(a);if(b){c=g.Gn(b,"ytp-prev-button")||g.Gn(b,"ytp-next-button");var m=g.Gn(b,"ytp-play-button"),n=g.Gn(b,"ytp-miniplayer-expand-watch-page-button");c?f=h=12:m?(b=g.Nh(b,this.element),h=b.x,f=b.y-12):n&&(h=g.Gn(b,"ytp-miniplayer-button-top-left"),f=g.Nh(b,this.element),b=g.Qh(b),h?(h=8,f=f.y+40):(h=f.x-l.width+b.width,f=f.y-20))}else h=c-l.width/2,d=25+(e||0);b=g.jL(this.player).getPlayerSize().width;e=f+(e||0);l=g.Rd(h,0,b-l.width);e?(a.style.top=e+
"px",a.style.bottom=""):(a.style.top="",a.style.bottom=d+"px");a.style.left=l+"px"};
g.k.showControls=function(){};
g.k.cu=function(){};
g.k.sg=function(){};g.r(N5,g.OL);N5.prototype.create=function(){};
N5.prototype.rf=function(){return!1};
N5.prototype.load=function(){this.player.hideControls();this.o.show()};
N5.prototype.unload=function(){this.player.showControls();this.o.hide()};g.cM.miniplayer=N5;})(_yt_player);

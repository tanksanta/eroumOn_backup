(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[311],{4396:function(s,e,n){(window.__NEXT_P=window.__NEXT_P||[]).push(["/find/step2-1",function(){return n(2647)}])},9483:function(s,e,n){"use strict";var i=n(5893),c=n(7294),t=n(828),r=n(1163),a=(0,t.Pi)(function(s){var e=s.percent,n=s.total,t=s.current,a=(0,r.useRouter)(),l=(0,c.useState)(!0),d=l[0],h=l[1],o=(0,c.useState)(1),u=o[0],x=o[1];return(0,c.useEffect)(function(){switch(a.pathname){case"/find/step2-1":h(!0);break;case"/find/step2-1/physical":x(1),h(!1);break;case"/find/step2-1/cognitive":x(2),h(!1);break;case"/find/step2-1/behavior":x(3),h(!1);break;case"/find/step2-1/nurse":x(4),h(!1);break;case"/find/step2-1/rehabilitate":x(5),h(!1);break;case"/find/step2-1/disease":case"/find/step2-1/diseaseSelect":x(6),h(!1);break;default:x(1),h(!0)}},[a.pathname]),(0,i.jsx)("div",{id:"header",children:(0,i.jsxs)("div",{className:"container",children:[(0,i.jsxs)("div",{className:"header-title",children:[(0,i.jsxs)("h1",{children:[(0,i.jsx)("strong",{children:"장기요양 예상등급"}),(0,i.jsxs)("small",{children:["장기요양인정등급 판정 전에",(0,i.jsx)("br",{})," 미리 등급을 알아보세요!"]})]}),(0,i.jsx)("p",{children:"TEST"})]}),(0,i.jsxs)("div",{className:"header-steps",children:[(0,i.jsx)("div",{className:"indictor",children:(0,i.jsx)("div",{className:"bubble",style:{width:"".concat(e,"%")},children:d?(0,i.jsx)("div",{className:"text",children:"Ready"}):(0,i.jsxs)("div",{className:"text",children:[(0,i.jsx)("img",{src:"/images/ico-steps".concat(u,".svg"),alt:""}),"".concat(t,"/").concat(n)]})})}),(0,i.jsx)("div",{className:"percent",children:"".concat(Math.floor(e),"%")})]})]})})});e.Z=a},2647:function(s,e,n){"use strict";n.r(e),n.d(e,{default:function(){return p}});var i=n(5893),c=n(7294),t=n(2962),r=n(1163),a=n(3206),l=n(7568),d=n(655),h=n(828),o=n(9669),u=n.n(o),x=n(4679),j=n(9483),m=(0,h.Pi)(function(){var s=(0,r.useRouter)(),e=(0,x.o)(),n=e.initializeScore,t=e.updateRankRanges,h=(0,c.useState)(0),o=h[0],m=h[1],p=(0,c.useState)(0),f=p[0],g=p[1],N=(0,c.useState)(0),v=N[0],k=N[1],b=(0,c.useState)(0),_=b[0],S=b[1],C=(0,c.useState)(0),R=C[0],w=C[1],y=(0,c.useState)(0),E=y[0],T=y[1],P=(0,c.useState)(0),Z=P[0],O=P[1],X=(0,c.useState)(0),z=X[0],B=X[1],F=(0,c.useState)(0),G=F[0],M=F[1],W=(0,c.useState)(0),q=W[0],A=W[1],D=(0,c.useState)(0),H=D[0],I=D[1];return(0,c.useEffect)(function(){function s(){return(s=(0,l.Z)(function(){var s,e,n,i,c,r,l,h;return(0,d.__generator)(this,function(s){switch(s.label){case 0:return[4,u().get("".concat(a.T5,"/api/test/info"))];case 1:return t((e=s.sent().data).rankRanges),m(e.physicalCount),g(e.cognitiveCount),k(e.behaviorCount),S(e.nurseCount),w(e.rehabilitateCount),T(e.physicalCount+e.cognitiveCount+e.behaviorCount+e.nurseCount+e.rehabilitateCount),(i=e.rankRanges.find(function(s){return 1===s.rank}))&&O(i.min),(c=e.rankRanges.find(function(s){return 2===s.rank}))&&B(c.min),(r=e.rankRanges.find(function(s){return 3===s.rank}))&&M(r.min),(l=e.rankRanges.find(function(s){return 4===s.rank}))&&A(l.min),(h=e.rankRanges.find(function(s){return 5===s.rank}))&&I(h.min),[2]}})})).apply(this,arguments)}n(),!function(){return s.apply(this,arguments)}()},[]),(0,i.jsxs)("section",{className:"h-200vh xl:h-screen flex flex-col",children:[(0,i.jsx)(j.Z,{percent:0,current:0,total:0}),(0,i.jsxs)("div",{id:"container",children:[(0,i.jsxs)("div",{className:"check-intro",children:[(0,i.jsxs)("div",{className:"total",children:[(0,i.jsx)("h2",{children:"구성"}),(0,i.jsxs)("div",{children:[(0,i.jsxs)("p",{children:[(0,i.jsx)("strong",{className:"numb1",children:"5"}),(0,i.jsx)("small",{children:"영역"})]}),(0,i.jsx)("p",{className:"split",children:"/"}),(0,i.jsxs)("p",{children:[(0,i.jsx)("strong",{className:"numb2",children:E}),(0,i.jsx)("small",{children:"항목"})]})]})]}),(0,i.jsxs)("dl",{className:"section1",children:[(0,i.jsxs)("dt",{children:["신체",(0,i.jsx)("em",{children:"기능"})]}),(0,i.jsx)("dd",{children:o})]}),(0,i.jsxs)("dl",{className:"section2",children:[(0,i.jsxs)("dt",{children:["인지",(0,i.jsx)("em",{children:"기능"})]}),(0,i.jsx)("dd",{children:f})]}),(0,i.jsxs)("dl",{className:"section3",children:[(0,i.jsx)("dt",{children:"행동변화"}),(0,i.jsx)("dd",{children:v})]}),(0,i.jsxs)("dl",{className:"section4",children:[(0,i.jsx)("dt",{children:"간호처치"}),(0,i.jsx)("dd",{children:_})]}),(0,i.jsxs)("dl",{className:"section5",children:[(0,i.jsx)("dt",{children:"재활"}),(0,i.jsx)("dd",{children:R})]})]}),(0,i.jsxs)("div",{className:"check-intro-rule",children:[(0,i.jsxs)("h2",{children:[(0,i.jsx)("small",{children:"점수별 등급"}),"산정 기준"]}),(0,i.jsxs)("ul",{children:[(0,i.jsx)("li",{children:(0,i.jsxs)("p",{className:"grade",children:[(0,i.jsx)("strong",{children:"1"}),"등급"]})}),(0,i.jsxs)("li",{children:[(0,i.jsxs)("p",{className:"point",children:[(0,i.jsx)("strong",{children:Z}),"점"]}),(0,i.jsxs)("p",{className:"grade",children:[(0,i.jsx)("strong",{children:"2"}),"등급"]})]}),(0,i.jsxs)("li",{children:[(0,i.jsxs)("p",{className:"point",children:[(0,i.jsx)("strong",{children:z}),"점"]}),(0,i.jsxs)("p",{className:"grade",children:[(0,i.jsx)("strong",{children:"3"}),"등급"]})]}),(0,i.jsxs)("li",{children:[(0,i.jsxs)("p",{className:"point",children:[(0,i.jsx)("strong",{children:G}),"점"]}),(0,i.jsxs)("p",{className:"grade",children:[(0,i.jsx)("strong",{children:"4"}),"등급"]})]}),(0,i.jsxs)("li",{children:[(0,i.jsxs)("p",{className:"point",children:[(0,i.jsx)("strong",{children:q}),"점"]}),(0,i.jsxs)("p",{className:"grade",children:[(0,i.jsx)("strong",{children:"5"}),"등급"]})]}),(0,i.jsxs)("li",{children:[(0,i.jsxs)("p",{className:"point",children:[(0,i.jsx)("strong",{children:H}),"점"]}),(0,i.jsxs)("p",{className:"grade",children:[(0,i.jsx)("strong",{children:"인지지원"}),"등급"]})]})]})]}),(0,i.jsxs)("div",{className:"check-intro-desc",children:[(0,i.jsx)("p",{children:"※"}),(0,i.jsxs)("p",{children:["본 테스트는 보건복지부에서 고시한 장기요양등급판정기준에 관한 고시 자료를 근거로 만들어 졌으며 실제 장기요양인정등급 심의 및 판정과는 다를 수 있으므로 ",(0,i.jsx)("strong",{children:"참고용으로만 확인"}),"해 주시기 바랍니다."]})]}),(0,i.jsx)("div",{className:"check-button is-sticky",children:(0,i.jsx)("button",{className:"btn btn-primary",onClick:function(){s.push("/find/step2-1/physical")},children:"테스트 시작"})})]})]})}),p=function(){var s=(0,r.useRouter)();return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(t.PB,{title:"장기요양 예상등급 TEST",description:"장기요양등급을 미리 받아볼 수 있습니다.",canonical:"".concat(a._n,"/"),openGraph:{url:"".concat(a._n,"/"),title:"장기요양 예상등급 TEST",description:"장기요양등급을 미리 받아볼 수 있습니다.",images:[{url:"".concat(a._n,"/imgs/eroum_icon.png"),width:128,height:128,alt:"eroum logo"},],site_name:"이로움"}}),(0,i.jsx)("main",{id:"simulation",className:"".concat(s.pathname.startsWith("/find/step2-1")?"mt-0":""),children:(0,i.jsx)(m,{})})]})}}},function(s){s.O(0,[826,669,774,888,179],function(){return s(s.s=4396)}),_N_E=s.O()}]);
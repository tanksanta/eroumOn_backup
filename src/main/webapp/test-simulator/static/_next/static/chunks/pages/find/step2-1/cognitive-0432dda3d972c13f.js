(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[349],{370:function(e,s,n){(window.__NEXT_P=window.__NEXT_P||[]).push(["/find/step2-1/cognitive",function(){return n(7279)}])},9483:function(e,s,n){"use strict";var t=n(5893),c=n(7294),i=n(828),a=n(1163),r=(0,i.Pi)(function(e){var s=e.percent,n=e.total,i=e.current,r=(0,a.useRouter)(),l=(0,c.useState)(!0),o=l[0],d=l[1],u=(0,c.useState)(1),h=u[0],f=u[1];return(0,c.useEffect)(function(){switch(r.pathname){case"/find/step2-1":d(!0);break;case"/find/step2-1/physical":f(1),d(!1);break;case"/find/step2-1/cognitive":f(2),d(!1);break;case"/find/step2-1/behavior":f(3),d(!1);break;case"/find/step2-1/nurse":f(4),d(!1);break;case"/find/step2-1/rehabilitate":f(5),d(!1);break;case"/find/step2-1/disease":case"/find/step2-1/diseaseSelect":f(6),d(!1);break;default:f(1),d(!0)}},[r.pathname]),(0,t.jsx)("div",{id:"header",children:(0,t.jsxs)("div",{className:"container",children:[(0,t.jsxs)("div",{className:"header-title",children:[(0,t.jsxs)("h1",{children:[(0,t.jsx)("strong",{children:"장기요양 예상등급"}),(0,t.jsxs)("small",{children:["장기요양인정등급 판정 전에",(0,t.jsx)("br",{})," 미리 등급을 알아보세요!"]})]}),(0,t.jsx)("p",{children:"TEST"})]}),(0,t.jsxs)("div",{className:"header-steps",children:[(0,t.jsx)("div",{className:"indictor",children:(0,t.jsx)("div",{className:"bubble",style:{width:"".concat(s,"%")},children:o?(0,t.jsx)("div",{className:"text",children:"Ready"}):(0,t.jsxs)("div",{className:"text",children:[(0,t.jsx)("img",{src:"/images/ico-steps".concat(h,".svg"),alt:""}),"".concat(i,"/").concat(n)]})})}),(0,t.jsx)("div",{className:"percent",children:"".concat(Math.floor(s),"%")})]})]})})});s.Z=r},7279:function(e,s,n){"use strict";n.r(s),n.d(s,{default:function(){return x}});var t=n(5893),c=n(7294),i=n(1163),a=n(7568),r=n(655),l=n(828),o=n(9669),d=n.n(o),u=n(3206),h=n(4679),f=n(9483),p=(0,l.Pi)(function(){var e=(0,i.useRouter)(),s=(0,h.o)(),n=s.cognitiveScores,l=s.updateCognitiveScore,o=s.updateCognitiveScores,p=s.updateCognitiveTestInfo,x=(0,c.useState)(),m=x[0],j=x[1],v=(0,c.useState)(),g=v[0],b=v[1],k=(0,c.useState)(),N=k[0],_=k[1];return(0,c.useEffect)(function(){function e(){return(e=(0,a.Z)(function(){var e,s,t,c,i;return(0,r.__generator)(this,function(a){switch(a.label){case 0:return[4,d().get("".concat(u.T5,"/api/cognitive"))];case 1:return t=(s=(e=a.sent()).data).questions,c=s.scoreEvaluations,j(t),b(c),t.length>0&&(n&&n.length>0?_(n):((i=Array(t[0].cases.length).fill(0))[t[0].cases.length-1]=1,_(i)),p(e.data)),[2]}})})).apply(this,arguments)}window.scrollTo(0,0),!function(){return e.apply(this,arguments)}()},[]),(0,t.jsxs)("section",{className:"h-100vh max-h-screen xl:h-screen flex flex-col",children:[(0,t.jsx)(f.Z,{percent:13/27*100,total:1,current:0}),(0,t.jsx)("div",{id:"container",children:(0,t.jsxs)("form",{className:"check-page2",children:[(0,t.jsxs)("div",{className:"check-title",children:[(0,t.jsx)("small",{children:"Check List"}),(0,t.jsx)("h2",{children:"인지기능"}),(0,t.jsx)("img",{src:"/images/ico-check-item2.png",alt:""}),(0,t.jsxs)("p",{children:["초기 치매, 알츠하이머의 진행 여부와도 관련이 있으며",(0,t.jsx)("br",{}),"치매로 인한 상황 판단능력을 측정합니다."]})]}),(0,t.jsxs)("div",{className:"check-desc",children:[(0,t.jsx)("u",{children:"최근 한 달간의 상황을 종합"}),"하여 아래 항목 중",(0,t.jsx)("br",{}),(0,t.jsx)("strong",{children:"해당하는 모든 증상을 선택"}),"해 주세요."]}),(0,t.jsx)("div",{className:"check-items",children:m&&m.map(function(e,s){return e.cases.map(function(e,n){return(0,t.jsxs)("label",{className:"check-item ".concat(n===(N?N.length:1)-1&&"is-disable check-symptom"),children:[(0,t.jsx)("input",{type:"checkbox",name:s.toString(),checked:!!N&&1===N[n],onClick:function(){if(N){if(n===N.length-1)_(N.map(function(e,s){return s===n?1:0}));else{var e=N.map(function(e,s){return s===n?1===N[n]?0:1:e});e[e.length-1]=0,_(e)}}}}),(0,t.jsx)("span",{children:e.content})]},n)})})}),(0,t.jsxs)("div",{className:"check-button",children:[(0,t.jsx)("div",{className:"btn",onClick:function(){e.back()},children:"뒤로가기"}),(0,t.jsx)("div",{className:"btn btn-primary",onClick:function(){if(N){if(0!==N[N.length-1])l(0);else{var s=N.reduce(function(e,s){return e+s},0),n=null==g?void 0:g.filter(function(e){return e.score===s});if(n&&1===n.length)l(n[0].evaluation);else{alert("평가 데이터가 옮바르지 않습니다.");return}}o(N),e.push("/find/step2-1/behavior")}},children:"다음 단계로"})]})]})})]})}),x=function(){var e=(0,i.useRouter)();return(0,t.jsx)("main",{id:"simulation",className:"".concat(e.pathname.startsWith("/find/step2-1")?"mt-0":""),children:(0,t.jsx)(p,{})})}}},function(e){e.O(0,[826,669,774,888,179],function(){return e(e.s=370)}),_N_E=e.O()}]);
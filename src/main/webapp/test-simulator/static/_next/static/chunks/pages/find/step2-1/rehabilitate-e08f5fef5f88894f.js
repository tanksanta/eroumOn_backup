(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[819],{8790:function(e,t,s){(window.__NEXT_P=window.__NEXT_P||[]).push(["/find/step2-1/rehabilitate",function(){return s(2100)}])},9483:function(e,t,s){"use strict";var n=s(5893),i=s(7294),c=s(828),a=s(1163),r=(0,c.Pi)(function(e){var t=e.percent,s=e.total,c=e.current,r=(0,a.useRouter)(),l=(0,i.useState)(!0),u=l[0],o=l[1],d=(0,i.useState)(1),h=d[0],f=d[1];return(0,i.useEffect)(function(){switch(r.pathname){case"/find/step2-1":o(!0);break;case"/find/step2-1/physical":f(1),o(!1);break;case"/find/step2-1/cognitive":f(2),o(!1);break;case"/find/step2-1/behavior":f(3),o(!1);break;case"/find/step2-1/nurse":f(4),o(!1);break;case"/find/step2-1/rehabilitate":f(5),o(!1);break;case"/find/step2-1/disease":case"/find/step2-1/diseaseSelect":f(6),o(!1);break;default:f(1),o(!0)}},[r.pathname]),(0,n.jsx)("div",{id:"header",children:(0,n.jsxs)("div",{className:"container",children:[(0,n.jsxs)("div",{className:"header-title",children:[(0,n.jsxs)("h1",{children:[(0,n.jsx)("strong",{children:"장기요양 예상등급"}),(0,n.jsxs)("small",{children:["장기요양인정등급 판정 전에",(0,n.jsx)("br",{})," 미리 등급을 알아보세요!"]})]}),(0,n.jsx)("p",{children:"TEST"})]}),(0,n.jsxs)("div",{className:"header-steps",children:[(0,n.jsx)("div",{className:"indictor",children:(0,n.jsx)("div",{className:"bubble",style:{width:"".concat(t,"%")},children:u?(0,n.jsx)("div",{className:"text",children:"Ready"}):(0,n.jsxs)("div",{className:"text",children:[(0,n.jsx)("img",{src:"/images/ico-steps".concat(h,".svg"),alt:""}),"".concat(c,"/").concat(s)]})})}),(0,n.jsx)("div",{className:"percent",children:"".concat(Math.floor(t),"%")})]})]})})});t.Z=r},2100:function(e,t,s){"use strict";s.r(t),s.d(t,{default:function(){return x}});var n=s(5893),i=s(7294),c=s(1163),a=s(7568),r=s(655),l=s(828),u=s(9669),o=s.n(u),d=s(3206),h=s(4679),f=s(9483),m=(0,l.Pi)(function(){var e=(0,c.useRouter)(),t=(0,i.useRef)([]),s=(0,i.useState)(1),l=s[0];s[1];var u=(0,h.o)(),m=u.rehabilitateScores,x=u.updateRehabilitateScore,p=u.updateRehabilitateScores,j=(0,i.useState)(),v=j[0],b=j[1],k=(0,i.useState)(),g=k[0],N=k[1],_=(0,i.useState)(0),S=_[0],w=_[1],y=(0,i.useState)(),E=y[0],R=y[1];return(0,i.useEffect)(function(){function e(){return(e=(0,a.Z)(function(){var e,t,s,n,i;return(0,r.__generator)(this,function(e){switch(e.label){case 0:return[4,o().get("".concat(d.T5,"/api/rehabilitate"))];case 1:return s=(t=e.sent().data).questions,n=t.scoreEvaluations,b(s),N(n),m&&m.length>0?R(m):s.length>0&&R(Array(s.filter(function(e){return"title"!==e.type}).length).fill(0)),[2]}})})).apply(this,arguments)}window.scrollTo(0,0),!function(){return e.apply(this,arguments)}()},[]),(0,i.useEffect)(function(){w(E?E.filter(function(e){return 0!==e}).length:0)},[E]),(0,n.jsxs)("section",{className:"h-100vh max-h-screen xl:h-screen flex flex-col",children:[(0,n.jsx)(f.Z,{percent:(1*l+12+1+1+1)/27*100,total:E?E.length:0,current:S}),(0,n.jsx)("div",{id:"container",children:(0,n.jsxs)("form",{className:"check-page5",children:[(0,n.jsxs)("div",{className:"check-title",children:[(0,n.jsx)("small",{children:"Check List"}),(0,n.jsx)("h2",{children:"재활"}),(0,n.jsx)("img",{src:"/images/ico-check-item5.png",alt:""}),(0,n.jsxs)("p",{children:["각 관절의 움직임과, 전체적인 팔, 다리의",(0,n.jsx)("br",{}),"운동 능력을 확인하는 단계 입니다."]})]}),(0,n.jsxs)("div",{className:"check-desc",children:[(0,n.jsx)("u",{children:"현재"})," 신청인의 각 부분의 움직임의 제한 여부를 보시고 ",(0,n.jsx)("strong",{children:"하나씩 질문에 답해 보세요."})]}),v&&v.map(function(e,s){return"title"===e.type?0===s?(0,n.jsx)("h3",{className:"check-title3 mt-5 xs:mt-6.5",children:e.question}):(0,n.jsx)("h3",{className:"check-title3 mt-21 xs:mt-26",children:e.question}):(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)("h4",{className:"check-title2 ".concat(e.img?"is-icon":""),dangerouslySetInnerHTML:{__html:(e.img?e.img:"")+e.question}}),(0,n.jsx)("div",{className:"check-items is-radio is-steps",ref:function(s){return t.current[e.id]=s},children:e.cases.map(function(s,i){return(0,n.jsxs)("label",{className:"check-item",children:[(0,n.jsx)("input",{type:"radio",name:e.id.toString(),onClick:function(){v.length-2>e.id+1&&t.current[e.id+1].scrollIntoView({behavior:"smooth",block:"center",inline:"nearest"}),R(null==E?void 0:E.map(function(t,n){return n===e.id?s.score:t}))},checked:E&&E.length>0&&E[e.id]===s.score}),(0,n.jsx)("span",{children:s.content})]},i)})})]})}),(0,n.jsxs)("div",{className:"check-button",children:[(0,n.jsx)("div",{className:"btn",onClick:function(){e.back()},children:"뒤로가기"}),(0,n.jsx)("div",{className:"btn btn-primary",onClick:function(){if(null==E?void 0:E.some(function(e){return 0===e}))alert("모든 항목을 선택해주세요.");else{var t=null==E?void 0:E.reduce(function(e,t){return e+t},0),s=null==g?void 0:g.filter(function(e){return e.score===t});s&&1===s.length?(x(s[0].evaluation),p(E||[]),e.push("/find/step2-1/disease")):alert("평가 데이터가 옮바르지 않습니다.")}},children:"다음 단계로"})]})]})})]})}),x=function(){var e=(0,c.useRouter)();return(0,n.jsx)("main",{id:"simulation",className:"".concat(e.pathname.startsWith("/find/step2-1")?"mt-0":""),children:(0,n.jsx)(m,{})})}}},function(e){e.O(0,[826,669,774,888,179],function(){return e(e.s=8790)}),_N_E=e.O()}]);
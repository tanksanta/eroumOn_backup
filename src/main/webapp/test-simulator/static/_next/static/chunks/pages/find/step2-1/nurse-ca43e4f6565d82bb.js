(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[83],{320:function(e,s,c){(window.__NEXT_P=window.__NEXT_P||[]).push(["/find/step2-1/nurse",function(){return c(3392)}])},9483:function(e,s,c){"use strict";var n=c(5893),a=c(7294),t=c(828),r=c(1163),i=(0,t.Pi)(function(e){var s=e.percent,c=e.total,t=e.current,i=(0,r.useRouter)(),l=(0,a.useState)(!0),d=l[0],o=l[1],h=(0,a.useState)(1),u=h[0],x=h[1];return(0,a.useEffect)(function(){switch(i.pathname){case"/find/step2-1":o(!0);break;case"/find/step2-1/physical":x(1),o(!1);break;case"/find/step2-1/cognitive":x(2),o(!1);break;case"/find/step2-1/behavior":x(3),o(!1);break;case"/find/step2-1/nurse":x(4),o(!1);break;case"/find/step2-1/rehabilitate":x(5),o(!1);break;case"/find/step2-1/disease":case"/find/step2-1/diseaseSelect":x(6),o(!1);break;default:x(1),o(!0)}},[i.pathname]),(0,n.jsx)("div",{id:"header",children:(0,n.jsxs)("div",{className:"container",children:[(0,n.jsxs)("div",{className:"header-title",children:[(0,n.jsxs)("h1",{children:[(0,n.jsx)("strong",{children:"장기요양 예상등급"}),(0,n.jsxs)("small",{children:["장기요양인정등급 판정 전에",(0,n.jsx)("br",{})," 미리 등급을 알아보세요!"]})]}),(0,n.jsx)("p",{children:"TEST"})]}),(0,n.jsxs)("div",{className:"header-steps",children:[(0,n.jsx)("div",{className:"indictor",children:(0,n.jsx)("div",{className:"bubble",style:{width:"".concat(s,"%")},children:d?(0,n.jsx)("div",{className:"text",children:"Ready"}):(0,n.jsxs)("div",{className:"text",children:[(0,n.jsx)("img",{src:"/images/ico-steps".concat(u,".svg"),alt:""}),"".concat(t,"/").concat(c)]})})}),(0,n.jsx)("div",{className:"percent",children:"".concat(Math.floor(s),"%")})]})]})})});s.Z=i},3392:function(e,s,c){"use strict";c.r(s),c.d(s,{default:function(){return h}});var n=c(5893),a=c(7294),t=c(1163),r=c(828),i=c(7880),l=c(9483),d=[{question:"Q15. 해당하는 모든 증상을 선택해 주세요.",type:"checkbox",cases:[{content:(0,n.jsxs)(n.Fragment,{children:["기관지 절개관 ",(0,n.jsx)("small",{children:"기관지를 절개하여 인공기도를 확보하는 간호"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["흡인 ",(0,n.jsx)("small",{children:"카테터 등으로 인위적으로 분비물을 제거하여 기도유지"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["산소요법 ",(0,n.jsx)("small",{children:"저산소증이나 저산소혈증을 치료, 감소 시키기 위해 산소공급장치를 통해 추가적인 산소 공급"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["욕창간호 ",(0,n.jsx)("small",{children:"장기적인 고정체위로 인해 압박 부위의 피부와 하부조직 손상되어 지속적인 드레싱과 체위변경 처치"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["경관 영양 ",(0,n.jsx)("small",{children:"구강으로 음식첩취가 아려워 관을 통해서 위, 십이지장 등에 직접 영양을 공급해야 하는 경우"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["암성통증 ",(0,n.jsx)("small",{children:"암의 진행을 억제하지 못하여 극심한 통증에 발생"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["도뇨관리 ",(0,n.jsx)("small",{children:"배뇨가 자율적으로 관리가 불가능하여 인위적으로 방광을 비우거나 관리"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["장루 ",(0,n.jsx)("small",{children:"인공항문을 통해 체외로 대변을 배설 시킴으로 부착장치의 지속적인 관리"})]}),score:1},{content:(0,n.jsxs)(n.Fragment,{children:["투석 ",(0,n.jsx)("small",{children:"장기적인 신부전증으로 인해 혈액 투석이 필요한 경우"})]}),score:1},{content:"해당하는 증상이 없다.",score:0},]},],o=(0,r.Pi)(function(){var e=(0,t.useRouter)(),s=(0,i.o)(),c=s.score,r=s.updateScore,o=s.nurseScore,h=s.updateNurseScore,u=(s.rank,s.updateRank),x=(0,a.useState)(0),m=x[0],j=x[1],f=(0,a.useState)(0),k=f[0],b=f[1],p=(0,a.useState)(0),v=p[0],N=p[1],g=(0,a.useState)(0),S=g[0],w=g[1],_=(0,a.useState)(0),E=_[0],F=_[1],y=(0,a.useState)(0),C=y[0],R=y[1],T=(0,a.useState)(0),P=T[0],O=T[1],X=(0,a.useState)(0),Z=X[0],q=X[1],L=(0,a.useState)(0),M=L[0],Q=L[1],W=(0,a.useCallback)(function(){r(c+o)},[c,r,o]);return(0,a.useEffect)(function(){0!==o&&W()},[o]),(0,a.useEffect)(function(){c<45?u(0):45<=c&&c<51?u(5):51<=c&&c<60?u(4):60<=c&&c<75?u(3):75<=c&&c<95?u(2):u(1)},[c]),(0,a.useEffect)(function(){window.scrollTo(0,0)},[]),(0,n.jsxs)("section",{className:"h-100vh max-h-screen xl:h-screen flex flex-col",children:[(0,n.jsx)(l.Z,{percent:55.55555555555556,total:1,current:0}),(0,n.jsx)("div",{id:"container",children:(0,n.jsxs)("form",{className:"check-page4",children:[(0,n.jsxs)("div",{className:"check-title",children:[(0,n.jsx)("small",{children:"Check List"}),(0,n.jsx)("h2",{children:"간호처치"}),(0,n.jsx)("img",{src:"/images/ico-check-item4.png",alt:""}),(0,n.jsxs)("p",{children:["증상이 심각하고 지속적인 관리가 필요한지",(0,n.jsx)("br",{}),"신청인의 상황에 맞게 요양 필요 여부와",(0,n.jsx)("br",{}),"필요한 간호처치를 판단합니다."]})]}),(0,n.jsxs)("div",{className:"check-desc",children:[(0,n.jsx)("u",{children:"최근 2주간의 상황을 종합"}),"하여 ",(0,n.jsx)("strong",{children:"필요하거나 제공 받고 있는 의료처리"}),"를 아래 항목 중 선택해 주세요."]}),(0,n.jsx)("div",{className:"check-items",children:d.map(function(e,s){return e.cases.map(function(e,c){return(0,n.jsxs)("label",{className:"check-item ".concat(9===c&&"is-disable check-symptom"),children:[(0,n.jsx)("input",{type:"checkbox",name:s.toString(),checked:0===c?1===m:1===c?1===k:2===c?1===v:3===c?1===S:4===c?1===E:5===c?1===C:6===c?1===P:7===c?1===Z:8===c?1===M:m+k+v+S+E+C+P+Z+M===0,onClick:function(){switch(c+1){case 1:1===m?j(0):j(e.score);break;case 2:1===k?b(0):b(e.score);break;case 3:1===v?N(0):N(e.score);break;case 4:1===S?w(0):w(e.score);break;case 5:1===E?F(0):F(e.score);break;case 6:1===C?R(0):R(e.score);break;case 7:1===P?O(0):O(e.score);break;case 8:1===Z?q(0):q(e.score);break;case 9:1===M?Q(0):Q(e.score);break;default:j(0),b(0),N(0),w(0),F(0),R(0),O(0),q(0),Q(0)}}}),(0,n.jsx)("span",{children:e.content})]},c)})})}),(0,n.jsxs)("div",{className:"check-button",children:[(0,n.jsx)("div",{className:"btn",onClick:function(){e.back()},children:"뒤로가기"}),(0,n.jsx)("div",{className:"btn btn-primary",onClick:function(){switch(m+k+v+S+E+C+P+Z+M){case 1:h(19.84);break;case 2:h(36.9);break;case 3:h(47.84);break;case 4:h(55.81);break;case 5:h(62.53);break;case 6:h(68.98);break;case 7:h(76.11);break;case 8:h(85.86);break;case 9:h(100);break;default:h(0)}e.push("/find/step2-1/rehabilitate")},children:"다음 단계로"})]})]})})]})}),h=function(){var e=(0,t.useRouter)();return(0,n.jsx)("main",{id:"simulation",className:"".concat(e.pathname.startsWith("/find/step2-1")?"mt-0":""),children:(0,n.jsx)(o,{})})}}},function(e){e.O(0,[826,774,888,179],function(){return e(e.s=320)}),_N_E=e.O()}]);
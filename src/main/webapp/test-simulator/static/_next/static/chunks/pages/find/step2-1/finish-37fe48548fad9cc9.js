(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[975],{1867:function(n,r,e){(window.__NEXT_P=window.__NEXT_P||[]).push(["/find/step2-1/finish",function(){return e(2511)}])},2511:function(n,r,e){"use strict";e.r(r),e.d(r,{default:function(){return f}});var s=e(5893),t=e(7294),i=e(2962),c=e(1163),o=e(3206);function a(n,r){(null==r||r>n.length)&&(r=n.length);for(var e=0,s=Array(r);e<r;e++)s[e]=n[e];return s}function l(n){return function(n){if(Array.isArray(n))return a(n)}(n)||function(n){if("undefined"!=typeof Symbol&&null!=n[Symbol.iterator]||null!=n["@@iterator"])return Array.from(n)}(n)||function(n,r){if(n){if("string"==typeof n)return a(n,r);var e=Object.prototype.toString.call(n).slice(8,-1);if("Object"===e&&n.constructor&&(e=n.constructor.name),"Map"===e||"Set"===e)return Array.from(e);if("Arguments"===e||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(e))return a(n,r)}}(n)||function(){throw TypeError("Invalid attempt to spread non-iterable instance.\\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}var d=e(828),h=e(4679),u=function(n,r){for(var e=[],s=r.questions,t=0;t<n.length;t++){var i=s[t],c=n[t]-1,o=i.cases[c],a=0;o.priority&&(a=o.priority),o.link&&e.push({priority:a,link:o.link})}return e},m=function(n,r){for(var e=[],s=r.questions[0],t=0;t<n.length;t++){var i=s.cases[t];if(n[t]){var c=0;i.priority&&(c=i.priority),i.link&&e.push({priority:c,link:i.link})}}return e},x=(0,d.Pi)(function(){var n=(0,c.useRouter)(),r=(0,h.o)(),e=r.rank,i=r.score,o=r.physicalScores,a=r.physicalTestInfo,d=r.cognitiveScores,x=r.cognitiveTestInfo,f=(0,t.useState)(),j=(f[0],f[1]);return(0,t.useEffect)(function(){window.scrollTo(0,0);var n=u(o,a),r=m(d,x),e=l(n).concat(l(r));e.sort(function(n,r){return r.priority-n.priority}),j(e.slice(0,4))},[]),(0,s.jsxs)("section",{className:"h-97.9vh max-h-[97.9vh] xl:h-[97.9vh] flex flex-col",children:[(0,s.jsx)("div",{id:"header",children:(0,s.jsx)("div",{className:"container",children:(0,s.jsxs)("div",{className:"header-result",children:[(0,s.jsxs)("h1",{className:"title",children:["장기요양 예상등급",(0,s.jsx)("small",{children:"테스트 결과"})]}),(0,s.jsxs)("div",{className:"grade",children:[(0,s.jsxs)("p",{className:"numb1",children:[(0,s.jsx)("small",{children:"등급"}),(0,s.jsx)("strong",{children:6!==e?e:"-"})]}),(0,s.jsxs)("p",{className:"numb2",children:[(0,s.jsx)("em",{children:i.toFixed(1)}),"점"]})]}),(0,s.jsx)("p",{className:"desc",children:1===e||2===e?"요양원, 주야간보호시설, 재가방문요양이 가능한 등급입니다.":3===e||4===e||5===e?"주야간보호시설, 재가방문요양이 가능한 등급입니다.":"장기요양보험의 혜택을 받으실 수 없는 등급입니다."}),(0,s.jsx)("div",{className:"mt-8",children:(0,s.jsx)("div",{className:"btn btn-pupple w-[100%]",onClick:function(){n.push("https://eroum.icubesystems.co.kr/main/conslt/form")},children:"1:1 상담요청"})})]})})}),(0,s.jsxs)("div",{id:"container",className:"flex-1 h-76 max-h-76",style:{paddingTop:"2.5rem",paddingBottom:"2.5rem"},children:[(0,s.jsxs)("dl",{className:"check-result",children:[(0,s.jsxs)("dt",{children:[(0,s.jsx)("span",{children:(0,s.jsx)("strong",{children:"!"})}),"등급 안내"]}),(0,s.jsx)("dd",{children:1===e||2===e?(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)("strong",{children:"".concat(e,"등급은 재가급여 등급")}),"은",(0,s.jsx)("br",{}),"요양원과 주야간보호시설, 재가요양시설 중 선택이 가능합니다."]}):3===e||4===e?(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)("strong",{children:"".concat(e,"등급은 재가급여 등급")}),"으로",(0,s.jsx)("br",{}),"주야간보호시설, 방문요양/목욕/간호 중 선택이 가능합니다.",(0,s.jsx)("br",{}),"다만 요양원은 입소가 불가능 하며,",(0,s.jsx)("br",{}),"사정에 의해 요양원 입소가 꼭 필요하신 경우 시설급여로 “",(0,s.jsx)("strong",{children:"급여변경신청"}),"”을 하여야 합니다."]}):5===e?(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)("strong",{children:"".concat(e,"등급은 재가급여 등급")}),"으로",(0,s.jsx)("br",{}),"주야간보호시설, 방문요양/목욕/간호 중 선택이 가능합니다."]}):(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)("strong",{children:"해당 등급"}),"으로",(0,s.jsx)("br",{}),"장기요양보험의 혜택을 받으실 수 없습니다.",(0,s.jsx)("br",{}),"어르신의 질병 치료나 요양이 필요하신 경우 건강보험을 통해서 요양병원을 이용하실 수 있습니다."]})})]}),(0,s.jsxs)("div",{className:"check-button mt-0 xs:mt-1",children:[(0,s.jsx)("div",{className:"btn h-12",onClick:function(){n.push("/find/step2-1")},children:"다시하기"}),(0,s.jsx)("div",{className:"btn btn-primary h-12",onClick:function(){n.push("/")},children:"완료"})]})]})]})}),f=function(){var n=(0,c.useRouter)();return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(i.PB,{title:"결과 - 장기요양 예상등급 TEST",canonical:"".concat(o._n,"/"),openGraph:{url:"".concat(o._n,"/"),title:"결과 - 장기요양 예상등급 TEST",images:[{url:"".concat(o._n,"/imgs/eroum_icon.png"),width:128,height:128,alt:"eroum logo"},],site_name:"이로움"}}),(0,s.jsx)("main",{id:"simulation",className:"".concat(n.pathname.startsWith("/find/step2-1")?"mt-0":""),children:(0,s.jsx)(x,{})})]})}}},function(n){n.O(0,[826,774,888,179],function(){return n(n.s=1867)}),_N_E=n.O()}]);
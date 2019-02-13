!function(t,e){"object"==typeof exports&&"object"==typeof module?module.exports=e(require("date-fns")):"function"==typeof define&&define.amd?define(["date-fns"],e):"object"==typeof exports?exports["date-queries"]=e(require("date-fns")):t["date-queries"]=e(t["date-fns"])}(window,function(t){return function(t){var e={};function r(s){if(e[s])return e[s].exports;var a=e[s]={i:s,l:!1,exports:{}};return t[s].call(a.exports,a,a.exports,r),a.l=!0,a.exports}return r.m=t,r.c=e,r.d=function(t,e,s){r.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:s})},r.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},r.t=function(t,e){if(1&e&&(t=r(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var s=Object.create(null);if(r.r(s),Object.defineProperty(s,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var a in t)r.d(s,a,function(e){return t[e]}.bind(null,a));return s},r.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return r.d(e,"a",e),e},r.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},r.p="",r(r.s=1)}([function(e,r){e.exports=t},function(t,e,r){"use strict";r.r(e);var s,a=r(0);e.default=function(t,e,r){return new s(t,e,r).value()},s=class{constructor(t,e,r){this.dtstart=t,this.dtstartStartOfDay=Object(a.startOfDay)(t),this.dtend=e,this.dtendStartOfDay=Object(a.endOfDay)(e),this.queries=r}value(){var t,e,r,s,a;for(t=0,e=(s=this.queries).length;t<e;t++)if(r=s[t],a=this.processQuery(r))return"function"==typeof r?a:r}processQuery(t){switch(t){case"now":case"today":return this.todayQuery();case"tomorrow":return this.tomorrowQuery();case"yesterday":return this.yesterdayQuery();case"this-week":return this.thisWeekQuery();case"next-week":return this.nextWeekQuery();case"past-week":return this.pastWeekQuery();case"this-month":return this.thisMonthQuery();case"next-month":return this.nextMonthQuery();case"past-month":return this.pastMonthQuery();case"this-year":return this.thisYearQuery();case"next-year":return this.nextYearQuery();case"past-year":return this.pastYearQuery();case"next":return this.nextQuery();case"past":return this.pastQuery();case"nearest-weekend":return this.nearestWeekendQuery();case"rest-of-this-week":return this.restOfThisWeekQuery();default:if("function"==typeof t)return t(this.dtstart,this.dtend)}}todayQuery(){var t;return this.dtend?(t=new Date,Object(a.isWithinRange)(t,this.dtstartStartOfDay,this.dtendStartOfDay)):Object(a.isToday)(this.dtstart)}tomorrowQuery(){var t;return this.dtend?(t=Object(a.addDays)(new Date,1),Object(a.isWithinRange)(t,this.dtstartStartOfDay,this.dtendStartOfDay)):Object(a.isTomorrow)(this.dtstart)}yesterdayQuery(){var t;return this.dtend?(t=Object(a.subDays)(new Date,1),Object(a.isWithinRange)(t,this.dtstartStartOfDay,this.dtendStartOfDay)):Object(a.isYesterday)(this.dtstart)}thisWeekQuery(){var t;return this.dtend?(t=new Date,Object(a.areRangesOverlapping)(Object(a.startOfWeek)(t),Object(a.endOfWeek)(t),this.dtstart,this.dtend)):Object(a.isThisWeek)(this.dtstart)}nextWeekQuery(){var t,e,r;return e=new Date,r=Object(a.addDays)(Object(a.endOfWeek)(e),1),t=Object(a.endOfWeek)(r),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}pastWeekQuery(){var t,e,r;return e=new Date,t=Object(a.subDays)(Object(a.startOfWeek)(e),1),r=Object(a.startOfWeek)(t),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}thisMonthQuery(){var t;return this.dtend?(t=new Date,Object(a.areRangesOverlapping)(Object(a.startOfMonth)(t),Object(a.endOfMonth)(t),this.dtstart,this.dtend)):Object(a.isThisMonth)(this.dtstart)}nextMonthQuery(){var t,e,r;return e=new Date,r=Object(a.addDays)(Object(a.endOfMonth)(e),1),t=Object(a.endOfMonth)(r),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}pastMonthQuery(){var t,e,r;return e=new Date,t=Object(a.subDays)(Object(a.startOfMonth)(e),1),r=Object(a.startOfMonth)(t),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}thisYearQuery(){var t;return this.dtend?(t=new Date,Object(a.areRangesOverlapping)(Object(a.startOfYear)(t),Object(a.endOfYear)(t),this.dtstart,this.dtend)):Object(a.isThisYear)(this.dtstart)}nextYearQuery(){var t,e,r;return e=new Date,r=Object(a.addDays)(Object(a.endOfYear)(e),1),t=Object(a.endOfYear)(r),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}pastYearQuery(){var t,e,r;return e=new Date,t=Object(a.subDays)(Object(a.startOfYear)(e),1),r=Object(a.startOfYear)(t),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}nextQuery(){return Object(a.isFuture)(Object(a.startOfDay)(this.dtstart))}pastQuery(){return this.dtend?Object(a.isPast)(Object(a.endOfDay)(this.dtend)):Object(a.isPast)(Object(a.endOfDay)(this.dtstart))}nearestWeekendQuery(){var t,e,r;return e=new Date,t=Object(a.endOfDay)(Object(a.lastDayOfWeek)(e,{weekStartsOn:1})),r=Object(a.startOfDay)(Object(a.subDays)(t,1)),this.dtend?Object(a.areRangesOverlapping)(r,t,this.dtstart,this.dtend):Object(a.isWithinRange)(this.dtstart,r,t)}restOfThisWeekQuery(){var t;return t=new Date,this.dtend?Object(a.areRangesOverlapping)(Object(a.startOfDay)(t),Object(a.endOfDay)(Object(a.endOfWeek)(t)),this.dtstart,this.dtend):Object(a.isAfter)(this.dtstart,Object(a.startOfDay)(t))&&Object(a.isThisWeek)(this.dtstart)}}}])});
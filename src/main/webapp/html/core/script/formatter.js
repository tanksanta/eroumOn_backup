
/*string formatter*/ 
String.prototype.format = function () {
    var formatted = this;
    for (var arg in arguments) {
        formatted = formatted.split('{' + arg + '}').join(arguments[arg]);
    }
    return formatted;
};

Number.prototype.format_money = function(){
	if(this==0) return 0;

	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');

	while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

	return n;
};

String.prototype.format_money = function(){
	var num = parseFloat(this);
	if( isNaN(num) ) return "0";

	return num.format_money();
};

String.prototype.substr_find = function(tempKey, splitor){
    if (this.length < 1) return this;

    var tempPos;
    tempPos = this.indexOf(tempKey);

    if (tempPos < 0) return '';
    
    var substr;
    
    var tempEnd = this.length;
    if (this.indexOf(splitor, tempPos) > 0){
        tempEnd = this.indexOf(splitor, tempPos);
    }
    substr = this.substring(tempPos + tempKey.length, tempEnd);

    return substr;
};

String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
};
String.prototype.replaceEnter = function() {
    return this.split('\n').join('').split('\r').join('');
};
String.prototype.nameShortDisp = function() {
    if (this == undefined || this.length < 5) return this;

    return this.substring(0, 3) + "...";
};
Date.prototype.addSeconds = function(seconds) {
    this.setSeconds(this.getSeconds() + seconds);
    return this;
};
Date.prototype.addMinutes = function(minutes) {
    this.setMinutes(this.getMinutes() + minutes);
    return this;
};
Date.prototype.addHours = function(hours) {
    this.setHours(this.getHours() + hours);
    return this;
};
Date.prototype.addDays = function(days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
};
Date.prototype.addWeeks = function(weeks) {
    this.addDays(weeks*7);
    return this;
  };
Date.prototype.addMonths = function (value) {
    var n = this.getDate();
    this.setDate(1);
    this.setMonth(this.getMonth() + value);
    this.setDate(Math.min(n, this.getDaysInMonth()));
    return this;
};
Date.prototype.addYears = function(years) {
    var dt = this.getDate();
    this.setFullYear(this.getFullYear() + years);
    var currDt = this.getDate();
    if (dt !== currDt) {  
      this.addDays(-currDt);
    }
    return this;
  };
Date.isLeapYear = function (year) { 
    return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0)); 
};

Date.getDaysInMonth = function (year, month) {
    return [31, (Date.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
};

Date.prototype.isLeapYear = function () { 
    return Date.isLeapYear(this.getFullYear()); 
};

Date.prototype.getDaysInMonth = function () { 
    return Date.getDaysInMonth(this.getFullYear(), this.getMonth());
};
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

Date.prototype.datediff = function(second) {
    // Take the difference between the dates and divide by milliseconds per day.
    // Round to nearest whole number to deal with DST.
    return Math.round(( this.getTime() - second.getTime() )/(1000*60*60*24));
}
Date.prototype.datediff2 = function(second) {
    // Take the difference between the dates and divide by milliseconds per day.
    // Round to nearest whole number to deal with DST.
    return Math.round(( this.getTime() - second.getTime() )/(1000));
}

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

Array.prototype.sortBy = function(p) {
    return this.slice(0).sort(function(a,b) {
      return (a[p] > b[p]) ? 1 : (a[p] < b[p]) ? -1 : 0;
    });
  }
Array.prototype.unique = function() {
    var a = this.concat();
    for(var i=0; i<a.length; ++i) {
        for(var j=i+1; j<a.length; ++j) {
            if(a[i] === a[j])
                a.splice(j--, 1);
        }
    }

    return a;
};

Array.prototype.clone = function () {
    var obj = this;
    if (obj === null || typeof(obj) !== 'object')
    return obj;
  
    var copy = obj.constructor();
  
    for (var attr in obj) {
      if (obj.hasOwnProperty(attr)) {
        copy[attr] = obj[attr];
      }
    }
  
    return copy;
};
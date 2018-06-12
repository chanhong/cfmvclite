component accessors=true 
hint="Shared helpers" output="false" {
	
    function img(string thisfile) {
        return "<img alt='|' border='0' src='"&thisfile&"' vspace='1' width='14' height='11'>";
    }
	
    function link2aNav(struct thislink) {
        local.arrow = "assets/img/navarrow.gif";
        return "<a href='"&thislink.url&"' target='"&thislink.target&"' title='"&thislink.title&"'>"
            & img(local.arrow) & thislink.label&"</a>";
    }

    function links2ali(links) {
    	
        ln = "";
        for (thislink in links) {
            ln = ln & Chr(10)& "<li>"&link2aNav(thislink)&"</li>";
        }
        return ln;    
    }

    function alink(struct thislink) {
        local.arrow = "assets/img/navarrow.gif";
        return Chr(10)&"<a href='"&thislink.url&"' target='"&thislink.target&"' title='"&thislink.title&"'>"
            & "<img alt='|' border='0' src='"&local.arrow&"' vspace='1' width='14' height='11'>"
            & thislink.label&"</a>";
    }
/*
    function urlKeyPair(iVar, kArray) {
        ret = "";
        i = 0;
        iArray = explode("/", ltrim(iVar, "/")); // take off 1st / before explode
        cArray = array_combine(kArray, array_pad(iArray, count(kArray), ''));
        foreach (cArray as key => value) {
            prefix = (i == 0) ? "?" : "&";
            if (len(value)>0)
                ret &= "#prefix##key#=#value#";
            i++;
        }
        return ret;
    }

    function path2URL(iVar, kArray) {
        ret = "?";
        switch (substr(iVar, 0, 1)) {
            case "/": // /users/add/1
                ret = urlKeyPair(iVar, kArray);
                break;
            case "?": // ?page1
                ret = iVar;
                break;
        }
        return ret;
    }

    function tap(iVar) {

        kArray = array['t', 'a', 'p1', 'p2']; // task, action, parm1, parm2
        return path2URL(iVar, kArray);
    }
*/


function marquee(str) {
    ret = (len(str)>0) ? '<marquee behavior="scroll" direction="left">' & str & '</marquee>' : "";
    return ret;
}

function bold(str, color = "darkgreen") {
    color = (len(color)>0) ? ' color=' & color : ' color=darkgreen';
    return '<b><i><font size=+1' & color & '>' & str & '</font></i></b>';
}

function meta(charset) {
    return '<meta http-equiv="X-UA-Compatible" content="text/html; IE=edge; charset=' & charset & '" />';
}

function classOddOrEven(url, lineCount, className) {
    return "<tr" & classTROddOrEven(lineCount, className) & ">" & url & "</tr>";
}

function classTROddOrEven(lineCount, className) {
    cmod = lineCount % 2;
    detclass = (cmod == 0) ?  " class='" & className & "Even'" : " class='" & className & "Odd'";
    return detclass;
}

function setMsgColor(iStr, color = "red") {

    if (len(iStr)>0)
        iStr = "<center>" & bold(iStr, color) & "</center>";
    return iStr;
}

function setMsg(fb = "feedback", color = "") {

    feedback = evaluate("session.#fb#");
    if (len(feedback)>0)
        feedback = setMsgColor(feedback, color);
    return feedback;
}
}
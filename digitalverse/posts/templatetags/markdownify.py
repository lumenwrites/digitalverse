# markdownify
from django import template
import markdown
import re
 
register = template.Library()
 
@register.filter
def markdownifyOne(text, short = "False"):
    if short == "True":
        try:
            text = text.split("<!-- more -->")[0].strip()
        except:
            pass
        text = text[:1024]

    # Urlify
    urlfinder = re.compile("([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}|((news|telnet|nttp|file|http|ftp|https)://)|(www|ftp)[-A-Za-z0-9]*\\.)[-A-Za-z0-9\\.]+):[0-9]*)?/[-A-Za-z0-9_\\$\\.\\+\\!\\*\\(\\),;:@&=\\?/~\\#\\%]*[^]'\\.}>\\),\\\"]")
    html = urlfinder.sub(r'<a href="\1">\1</a>', html)    


    
    html = markdown.markdown(text)

    return html


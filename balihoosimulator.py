import urllib.request
import re

class BalihooSimulator(object):

    def __init__(self, url):
        self._qre = re.compile("\?q=(.*)\&d=")
        self._requests = [url + r for r in [
            "?q=Ping&d=Please+return+OK+so+that+I+know+your+service+works.",
            "?q=Referrer&d=How+did+you+hear+about+this+position%3F",
            "?q=Puzzle&d=Please+solve+this+puzzle%3A%0A+ABCD%0AA--%3E-%0AB--%3C-%0AC--%3D-%0AD%3E---%0A",
            "?q=Position&d=Which+position+at+Balihoo+are+you+applying+for%3F",
            "?q=Name&d=What+is+your+full+name%3F",
            "?q=Status&d=Can+you+provide+proof+of+eligibility+to+work+in+the+US%3F",
            "?q=Resume&d=Please+provide+a+URL+where+we+can+download+your+resume+and+cover+letter.",
            "?q=Source&d=Please+provide+a+URL+where+we+can+download+the+source+code+of+your+resume+submission+web+service.",
        ]]

    def make_requests(self):
        for request in self._requests:
            keyword = "<no q>"
            qs = self._qre.search(request).groups()
            if len(qs) > 0:
                keyword = qs[0]
            with urllib.request.urlopen(request) as response:
                txt = response.read().decode(encoding='UTF-8')
                print("%s: %s" % (keyword, txt))



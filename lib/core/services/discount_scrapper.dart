import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:http/http.dart' as http;

List<String> discountKeywords = [
  'Discount',
  'Sale',
  'Deal',
  'Special offer',
  'Promotional price',
  'Clearance',
  'Markdown',
  'Coupon',
  'Promo code',
  'Bargain',
  'Reduced price',
  'Savings',
  'Limited time offer',
  'Flash sale',
  'Percent off',
  'Bonus',
  'Free',
  'Price drop',
  'Exclusive offer',
  'Best price',
  'Hot deal',
  'Last chance',
  'Steal',
  'Massive savings',
  'Unbeatable prices',
  'Clearance sale',
  'Mega sale',
  'Extra discount',
  'Doorbuster deal',
  'Big savings',
];

Future<bool> checkForDiscounts(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final soup = BeautifulSoup(response.body);
    return searchForDiscounts(soup);
  } else {
    print('Failed to load the webpage: ${response.statusCode}');
    return false;
  }
}

bool searchForDiscounts(BeautifulSoup soup) {
  // extensive search for discounts in the page using recursion

  // get all divs
  final divs = soup.findAll('div');
  for (var div in divs) {
    // check if the div has any text
    if (div.text != null) {
      // check if the text contains any of the keywords
      for (var keyword in discountKeywords) {
        if (div.text.contains(keyword)) {
          return true;
        }
      }
    }
  }

  // get all spans
  final spans = soup.findAll('span');
  for (var span in spans) {
    // check if the span has any text
    if (span.text != null) {
      // check if the text contains any of the keywords
      for (var keyword in discountKeywords) {
        if (span.text.contains(keyword)) {
          return true;
        }
      }
    }
  }

  // get all paragraphs
  final paragraphs = soup.findAll('p');
  for (var paragraph in paragraphs) {
    // check if the paragraph has any text
    if (paragraph.text != null) {
      // check if the text contains any of the keywords
      for (var keyword in discountKeywords) {
        if (paragraph.text.contains(keyword)) {
          return true;
        }
      }
    }
  }

  // // get all headers
  // final headers = soup.findAll('h1');
  // for (var header in headers) {
  //   // check if the header has any text
  //   if (header.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (header.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  // // get all headers
  // final headers2 = soup.findAll('h2');
  // for (var header in headers2) {
  //   // check if the header has any text
  //   if (header.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (header.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  // // get all headers
  // final headers3 = soup.findAll('h3');
  // for (var header in headers3) {
  //   // check if the header has any text
  //   if (header.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (header.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  // // get all headers
  // final headers4 = soup.findAll('h4');

  // for (var header in headers4) {
  //   // check if the header has any text
  //   if (header.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (header.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  // // get all headers

  // final headers5 = soup.findAll('h5');

  // for (var header in headers5) {
  //   // check if the header has any text
  //   if (header.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (header.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  // // get all headers

  // final headers6 = soup.findAll('h6');

  // for (var header in headers6) {
  //   // check if the header has any text
  //   if (header.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (header.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  // // get all links
  // final links = soup.findAll('a');

  // for (var link in links) {
  //   // check if the link has any text
  //   if (link.text != null) {
  //     // check if the text contains any of the keywords
  //     for (var keyword in discountKeywords) {
  //       if (link.text.contains(keyword)) {
  //         return true;
  //       }
  //     }
  //   }
  // }

  return false;
}

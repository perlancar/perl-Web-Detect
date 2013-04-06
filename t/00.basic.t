use Test::More tests => 4;

use Web::Detect;

ok( !defined &detect_web, 'detect_web() not exported by default' );

Web::Detect->import("detect_web");
ok( defined &detect_web, 'detect_web() is exportable' );

{
    local %ENV = ();
    ok( !detect_web(), 'detect_web() false based on ENV' );
    $ENV{GATEWAY_INTERFACE} = 'CGI';
    ok( detect_web(), 'detect_web() true based on ENV' );
}

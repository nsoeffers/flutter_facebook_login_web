import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:js';


class FacebookLoginWebPlugin {

	static void registerWith(Registrar registrar) {
		final MethodChannel channel = MethodChannel(
			'com.roughike/flutter_facebook_login',
			const StandardMethodCodec(),
			registrar.messenger
		);
		final FacebookLoginWebPlugin instance = FacebookLoginWebPlugin();
		channel.setMethodCallHandler(instance.handleMethodCall);
	}


	Future<dynamic> handleMethodCall(MethodCall call) async {
		switch (call.method) {
			case 'logIn':
				return _login();
			case 'logOut':
				return _logout();
			default:
				throw PlatformException(
					code: 'Unimplemented',
					details: "The url_launcher plugin for web doesn't implement "
						"the method '${call.method}'");
		}
	}

	bool _isLoggedIn = false;

	_login() {
		Completer completer = new Completer();
		context["FB"].callMethod('login', [ (result) async {
			_isLoggedIn = true;
			completer.complete({
					"status": "loggedIn",
					"accessToken": {
						"token" : result["authResponse"]["accessToken"],
						"userId" : result["authResponse"]["userID"],
						"expires" : result["authResponse"]["expiresIn"],
						"permissions": ["email"],
						"declinedPermissions" : []
					}
			});
		}]);
		return completer.future;
	}

	_logout() {
		if ( !_isLoggedIn ){
			return Future.value();
		}
		Completer completer = new Completer();
		context["FB"].callMethod('logout', [ (_) async {
			_isLoggedIn = false;
			completer.complete();
		}]);
		return completer.future;
	}
}
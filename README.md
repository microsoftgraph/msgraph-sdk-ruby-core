# Microsoft Graph Core SDK for Ruby

Get started with the Microsoft Graph Core SDK for Ruby by integrating the [Microsoft Graph API](https://learn.microsoft.com/graph/overview) into your Ruby application!

> **Note:** Although you can use this library directly, we recommend you use the [v1](https://github.com/microsoftgraph/msgraph-sdk-ruby) or [beta](https://github.com/microsoftgraph/msgraph-beta-sdk-ruby) library which rely on this library and additionally provide a fluent style ruby API and models.
>
> **Note:** the Microsoft Graph Ruby SDK is currently in Community Preview. During this period we're expecting breaking changes to happen to the SDK based on community's feedback. Checkout the [known limitations](https://github.com/microsoftgraph/msgraph-sdk-ruby-core/issues/1).

## Samples and usage guide

- [Middleware usage](https://github.com/microsoftgraph/msgraph-sdk-design/)

## 1. Installation

run `gem install microsoft_graph_core` or include `gem microsoft_graph_core` in your gemfile.

## 2. Getting started

### 2.1 Register your application

Register your application by following the steps at [Register your app with the Microsoft Identity Platform](https://learn.microsoft.com/graph/auth-register-app-v2).

### 2.2 Create an AuthenticationProvider object

An instance of the **MicrosoftGraphServiceClient** class handles building client. To create a new instance of this class, you need to provide an instance of **AuthenticationProvider**, which can authenticate requests to Microsoft Graph.

For an example of how to get an authentication provider, see [choose a Microsoft Graph authentication provider](https://learn.microsoft.com/graph/sdks/choose-authentication-providers?tabs=Ruby).

> Note: we are working to add the getting started information for Ruby to our public documentation, in the meantime the following sample should help you getting started.

```Ruby
require "microsoft_kiota_authentication_oauth"

context = MicrosoftKiotaAuthenticationOauth::ClientCredentialContext.new("<the tenant id from your app registration>", "<the client id from your app registration>", "<the client secret from your app registration>")

authentication_provider = MicrosoftKiotaAuthenticationOauth::OAuthAuthenticationProvider.new(context, nil, ["Files.Read"])
```

### 2.3 Get a Graph Service Client and Adapter object

You must get a **MicrosoftGraphRequestAdapter** object to make requests against the service.

```ruby
require "microsoft_graph"

adapter = MicrosoftGraph::MicrosoftGraphRequestAdapter.new(authentication_provider)
```

## 3. Make requests against the service

After you have a **MicrosoftGraphRequestAdapter** that is authenticated, you can begin making calls against the service. The requests against the service look like our [REST API](https://learn.microsoft.com/graph/api/overview?view=graph-rest-1.0).

### 3.1 Get the user's drive

To retrieve the user's drive:

```ruby
import "microsoft_kiota_abstractions"
request_information = MicrosoftKiotaAbstractions::RequestInformation.new
request_information.url = "https://graph.microsoft.com/v1.0/me"
result = adapter.send_async(request_information, lambda |pn| { return UserModel.new }, nil, nil).resume
```

## 4. Issues

For known issues, see [issues](https://github.com/MicrosoftGraph/msgraph-sdk-ruby-core/issues).

## 5. Contributions

The Microsoft Graph SDK is open for contribution. To contribute to this project, see [Contributing](https://github.com/microsoftgraph/msgraph-sdk-ruby-core/blob/main/CONTRIBUTING.md).

## 6. License

Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the [MIT license](LICENSE).

## 7. Third-party notices

[Third-party notices](THIRD%20PARTY%20NOTICES)

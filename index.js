import { ApolloProvider } from "@apollo/client";
import { registerRootComponent } from "expo";
// registerRootComponent calls AppRegistry.registerComponent('main', () => App);
// It also ensures that whether you load the app in the Expo client or in a native build,
// the environment is set up appropriately
import React from "react";
import App from "./App";
import client from "./graphql/client";

function Main() {
  return (
    <ApolloProvider client={client}>
      <App />
    </ApolloProvider>
  );
}

registerRootComponent(Main);

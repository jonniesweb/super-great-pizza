/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "core-js/stable";
import "regenerator-runtime/runtime";

import ApolloClient, { gql } from 'apollo-boost';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { ApolloProvider, useQuery } from '@apollo/react-hooks';
import React from 'react';
import { render } from 'react-dom';


const client = new ApolloClient({
  uri: '/graphql',
  headers: {
    'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').getAttribute('content'),
  },
  credentials: 'same-origin',
  cache: new InMemoryCache(),
});


const storeByCodeQuery = gql`
{
  storeByCode(code: "10503") {
    discounts {
      id
      name
      code
      price
    }
  }
}
`;

const storesQuery = gql`
{
  stores {
    address
    code
  }
}
`;

function StoresSelector() {
  const { loading, error, data } = useQuery(storesQuery);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error </p>;

  const options = data.stores.map(({ address, code }) => (
    <option key={code} value={code}>{address}</option>
  ));

  return (
    <select>{options}</select>
  );
}

function Discounts() {
  const { loading, error, data } = useQuery(storeByCodeQuery);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error </p>;

  return data.storeByCode.discounts.map(({ name, code, price, productGroups }) => (
    <div key={code}>
      <p>
        {name}: {price}
      </p>
    </div>
  ));
}


const App = () => (
  <ApolloProvider client={client}>
    <div>
      <StoresSelector/>
      <Discounts/>
    </div>
  </ApolloProvider>
);

render(<App />, document.getElementById('root'));

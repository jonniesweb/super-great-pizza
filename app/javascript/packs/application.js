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
import React, { useState } from 'react';
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
query DiscountsForStore($storeId: String!) {
  storeByCode(code: $storeId) {
    discounts {
      id
      code
      price
      name
    }
  }
}
`;

const storesQuery = gql`
query AllStores {
  stores {
    address
    code
  }
}
`;

function StoresSelector(props) {
  const { loading, error, data } = useQuery(storesQuery);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error #{error.message}</p>;

  const options = data.stores.map(({ address, code }) => (
    <option key={code} value={code}>{address}</option>
  ));

  return (
    <select onChange={(event) => props.onStoreChange(event.target.value)}>{options}</select>
  );
}

function Discounts(props) {
  const storeId = props.storeId;

  if (storeId == null) return null;
  
  const { loading, error, data } = useQuery(storeByCodeQuery, { variables: { storeId: storeId }});

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error #{error.message}</p>;

  return data.storeByCode.discounts.map(({ name, code, price, productGroups }) => (
    <div key={code}>
      <p>
        {name}: {price}
      </p>
    </div>
  ));
}

function App() {
  const [storeId, setStoreId] = useState(null);

  return (
    <ApolloProvider client={client}>
      <div>
        <StoresSelector onStoreChange={setStoreId}/>
        <Discounts storeId={storeId}/>
      </div>
    </ApolloProvider>
  );
}

render(<App />, document.getElementById('root'));

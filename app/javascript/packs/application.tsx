/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import { ApolloProvider } from "@apollo/react-hooks";
import * as React from "react";
import { useState } from "react";
import { render } from "react-dom";
import { useAllStoresQuery, useDiscountsForStoreQuery } from "../generated/graphql";
import { client } from "./client";

function StoresSelector(props: { onStoreChange: (arg0: string) => void }) {
  const { loading, error, data } = useAllStoresQuery();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error #{error.message}</p>;

  const options = data.stores.map(({ address, code }) => (
    <option key={code} value={code}>
      {address}
    </option>
  ));

  return (
    <select onChange={event => props.onStoreChange(event.target.value)}>
      {options}
    </select>
  );
}

function Discounts(props: { storeId: string }) {
  const storeId = props.storeId;

  const { loading, error, data } = useDiscountsForStoreQuery({
    variables: { storeId: storeId },
    skip: !storeId
  });

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error ${error}</p>;
  if (data == null) return <p>No discounts found for store</p>;

  return (
    <>
      {data.storeByCode.discounts.map(({ name, code, price }) => (
        <div key={code}>
          <p>
            {name}: {price}
          </p>
        </div>
      ))}
    </>
  );
}

function App() {
  const [storeId, setStoreId] = useState(null);

  return (
    <ApolloProvider client={client}>
      <div>
        <StoresSelector onStoreChange={setStoreId} />
        <Discounts storeId={storeId} />
      </div>
    </ApolloProvider>
  );
}

render(<App />, document.getElementById("root"));

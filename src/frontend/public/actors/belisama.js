
import { Actor, HttpAgent } from "@dfinity/agent";
import {
  idlFactory,
  canisterId,
} from "ic:canisters/belisama";

const agent = new HttpAgent();
const actor = Actor.createActor(idlFactory, { agent, canisterId });

export default actor;
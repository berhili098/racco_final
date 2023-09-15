import 'package:racco_final/models/palette.dart';

const primaryColor = Palette.kToDark;
const baseUrl = "http://127.0.0.1:8000/api";
// const baseUrl = "http://104.193.143.216/~newera22/app/public/api";
  enum BlocageClient {
  adresseErroneDeploye,
  adresseErroneNonDeploye,
  blocageFacadeCoteApparetemment,
  blocageFacadeCoteMagasin,
  blocageFacadeCoteVilla,
  blocagePassageCoteSyndic,
  clientAnnuleSaDemande,
  contactErronee,
  demandeEnDouble,
  horsPlaque,
  indisponible,
  injoignableSMS,
  manqueID,
  caleTransportDgrades,
  manqueCableTransport,
  gponSature,
  nonEligible,
  cabelTransportSature,
  splitterSature,
  pasSignal,
  problemeVerticalite,
  blocageBdc,
  blocageSwan,
  blocageBesoinJartterier,
}
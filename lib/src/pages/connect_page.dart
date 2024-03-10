import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/models/action_state.dart';
import 'package:partner/src/models/connect_request.dart';
import 'package:partner/src/models/partner.dart';
import 'package:partner/src/providers/connect_request_provider.dart';
import 'package:partner/src/utils/enums.dart';
import 'package:partner/src/widgets/global_app_bar.dart';
import 'package:provider/provider.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(title: const Text("Partner Requests")),
      body: Consumer<ConnectRequestProvider>(builder: (context, provider, __) {
        final ActionState requestsState = provider.getConnectRequestsState;
        if (requestsState.state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (requestsState.state.isFailed) {
          return Center(child: Text(requestsState.errorMessage));
        } else if (requestsState.state.isSuccess) {
          final List<ConnectRequest> requests =
              requestsState.successData as List<ConnectRequest>;
          if (requests.isEmpty) {
            return const Center(
              child: Text("No partner connect requests"),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 80),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              ConnectRequest request = requests[index];
              return _requestCard(request);
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  Widget _requestCard(ConnectRequest request) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 24),
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppThemeColor.grayColor.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppThemeColor.darkBlueColor,
              ),
              child: const Icon(
                Icons.person,
                color: AppThemeColor.pureWhiteColor,
                size: 32,
              ),
            ),
            title: Text(request.sender?.username ?? ""),
            subtitle: Text(request.sender?.phone ?? ""),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => context
                      .read<ConnectRequestProvider>()
                      .respondRequest(RequestStatus.accepted, request),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: const BoxDecoration(
                      color: AppThemeColor.darkBlueColor,
                    ),
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppThemeColor.pureWhiteColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context
                      .read<ConnectRequestProvider>()
                      .respondRequest(RequestStatus.rejected, request),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: const BoxDecoration(color: Colors.redAccent),
                    child: const Text(
                      "Reject",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppThemeColor.pureWhiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

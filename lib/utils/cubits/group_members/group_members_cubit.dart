import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_members/group_members_states.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> implements Observer {
  GroupMembersCubit(
      {GroupMembersState initialState =
          const GroupMembersErrorState('No members available')})
      : super(initialState) {
    loadGroupMembers();
    GroupServices().addObserver(this);
  }

  @override
  Future<void> close() {
    GroupServices().removeObserver(this);
    return super.close();
  }

  @override
  void update() {
    reloadGroupMembers();
  }

  /// This method is used to load the group members.
  Future<void> loadGroupMembers() async {
    emit(const GroupMembersLoadingState());
    logger.d('Group members state loading');
    try {
      final group = await UserServices().getGroupOfUser(UserSessionServices()
          .getUserId());
      if (group != null) {
        final members = await GroupServices().getMembersOfGroup(group.id);
        emit(GroupMembersLoadedState(members));
        logger.d('Group members state loaded: $members');
      } else {
        emit(const GroupMembersErrorState('User is not in a group'));
        logger.e('Group members state error: User is not in a group');
      }
    } catch (e) {
      emit(GroupMembersErrorState(e.toString()));
      logger.e('Group members state error: $e');
    }
  }

  /// This method is used to reload the group members.
  Future<void> reloadGroupMembers() async {
    logger.d('Group members state reloading');
    try {
      final group = await UserServices().getGroupOfUser(UserSessionServices()
          .getUserId());
      if (group != null) {
        final members = await GroupServices().getMembersOfGroup(group.id);
        emit(GroupMembersLoadedState(members));
        logger.d('Group members state reloaded: $members');
      } else {
        emit(const GroupMembersErrorState('User is not in a group'));
        logger.e('Group members state error: User is not in a group');
      }
    } catch (e) {
      emit(GroupMembersErrorState(e.toString()));
      logger.e('Group members state error: $e');
    }
  }
}
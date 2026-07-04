#pragma semicolon 1

#define E78_MAX_WALL_THICKNESS 256.0
#define E78_STEP_SIZE 8.0 

static const float E78_HULL_MIN[3] = {-24.0, -24.0, 0.0};
static const float E78_HULL_MAX[3] = {24.0, 24.0, 82.0};

public Action E78_OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon) {
     if(buttons & IN_FORWARD && buttons & IN_RELOAD) {
          E78_TryTeleport(client);
     }

     return Plugin_Continue;
}

public bool E78_IsBlockedForward(int client) {
     float pos[3], ang[3], dir[3], endPos[3];
     GetClientEyePosition(client, pos);
     GetClientEyeAngles(client, ang);
     GetAngleVectors(ang, dir, NULL_VECTOR, NULL_VECTOR);
     
     float checkDist = 40.0;
     endPos[0] = pos[0] + dir[0] * checkDist;
     endPos[1] = pos[1] + dir[1] * checkDist;
     endPos[2] = pos[2] + dir[2] * checkDist;
     
     TR_TraceRayFilter(
          pos,
          endPos,
          MASK_PLAYERSOLID,
          RayType_EndPoint,
          TraceFilter_WorldOnly
     );
     
     bool hit = TR_DidHit();
     
     return hit;
}

public bool E78_FindExit(int client, float exitPos[3]) {
     float eye[3], ang[3], dir[3];
     GetClientEyePosition(client, eye);
     GetClientEyeAngles(client, ang);
     GetAngleVectors(ang, dir, NULL_VECTOR, NULL_VECTOR);
     
     float depth = 0.0;
     bool foundExit = false;
     
     while(depth < E78_MAX_WALL_THICKNESS) {
          float test[3];
          test[0] = eye[0] + dir[0] * depth;
          test[1] = eye[1] + dir[1] * depth;
          test[2] = eye[2] + dir[2] * depth;
          
          TR_TraceHullFilter(
               test,
               test,
               E78_HULL_MIN,
               E78_HULL_MAX,
               MASK_PLAYERSOLID,
               TraceFilter_WorldOnly
          );
          
          if(TR_StartSolid()) {
               foundExit = true;
               break;
          }
          
          depth += E78_STEP_SIZE;
     }
     
     if(!foundExit) {
          return false;
     }
     
     while(depth < E78_MAX_WALL_THICKNESS) {
          float test[3];
          test[0] = eye[0] + dir[0] * depth;
          test[1] = eye[1] + dir[1] * depth;
          test[2] = eye[2] + dir[2] * depth;
          
          TR_TraceHullFilter(
               test,
               test,
               E78_HULL_MIN,
               E78_HULL_MAX,
               MASK_PLAYERSOLID,
               TraceFilter_WorldOnly
          );
          
          if(!TR_StartSolid()) {
               break;
          }
          
          depth += E78_STEP_SIZE;
     }
     
     if(depth >= E78_MAX_WALL_THICKNESS) {
          return false;
     }
     
     float extraOffset = 10.0;
     exitPos[0] = eye[0] + dir[0] * (depth + extraOffset);
     exitPos[1] = eye[1] + dir[1] * (depth + extraOffset);
     exitPos[2] = eye[2] + dir[2] * (depth + extraOffset);
     
     if(TR_PointOutsideWorld(exitPos)) {
          return false;
     }
     
     TR_TraceHullFilter(
          exitPos,
          exitPos,
          E78_HULL_MIN,
          E78_HULL_MAX,
          MASK_PLAYERSOLID,
          TraceFilter_WorldOnly
     );
     
     if(TR_StartSolid()) {
          return false;
     }
     
     return true;
}

public bool E78_TryTeleport(int client) {
     if(!(GetEntityFlags(client) & FL_ONGROUND)) {
          return false;
     }
     
     if(!E78_IsBlockedForward(client)) {
          return false;
     }
          
     float exitPos[3];
     if(!E78_FindExit(client, exitPos)) {
          return false;
     }
     
     float groundPos[3];
     groundPos[0] = exitPos[0];
     groundPos[1] = exitPos[1];
     groundPos[2] = exitPos[2] - 100.0;
     
     TR_TraceRayFilter(
          exitPos,
          groundPos,
          MASK_PLAYERSOLID,
          RayType_EndPoint,
          TraceFilter_WorldOnly
     );
     
     float groundDist = TR_GetFraction() * 100.0;
     
     if(groundDist > 80.0 || groundDist < 10.0) {
          return false;
     }
          
     TeleportEntity(client, exitPos, NULL_VECTOR, NULL_VECTOR);
     return true;
}